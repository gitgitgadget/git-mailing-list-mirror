From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Add tests for git format-patch --to and format.to config
 option
Date: Sat, 06 Mar 2010 16:06:18 -0800
Message-ID: <4B92EDFA.1000602@gmail.com>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org> <20100306003946.GD27414@genesis.frugalware.org> <7vr5nykx55.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 01:06:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No411-0001AM-Ir
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 01:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab0CGAGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 19:06:25 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65433 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab0CGAGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 19:06:24 -0500
Received: by gyh3 with SMTP id 3so276345gyh.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 16:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fkpXRHBA50dJvSdt5IQ2fKZglBQgs+vofyTqyH/nfxs=;
        b=J5W1mduND+oLtVQUXbWsOx3NJPsmQlJPT4Vgz9fJcsZDmnWJCRpu8YQwt+NWbfQvGu
         BKN//nDV/j1ihBBVJxTaObVU2LJlqi7a/VdjdlAYbgr4iqYNYkEl9hPa4bhLMHoAldXh
         oG8JwYH78IoPVo4v6xsjiFJIPUaqYcX4Z68zU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=asmyqtv8gy4+sWvj80hC1IIuTzBM3dbUPxSfa4oHTwVNlKUzkQVGzBkNLabMYTxLGv
         Co9LXj9O9uyM+14QtWTVZgR4uTYsP3tdg70zZtLSGD6uc2yHtsb8cOk2JFxVbxLjc0mB
         onkz8PrqSdCVBT2znCqIegkwX+RDUZGyAdnWg=
Received: by 10.91.19.3 with SMTP id w3mr1806470agi.60.1267920381821;
        Sat, 06 Mar 2010 16:06:21 -0800 (PST)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 4sm1176206ywi.51.2010.03.06.16.06.20
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 16:06:21 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7vr5nykx55.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141630>

On 03/05/2010 06:21 PM, Junio C Hamano wrote:
> This reveals that --to does not follow the usual rule to override
> corresponding configuration.  Is that really what we want?  IOW, when the
> command line says scipient, shouldn't we stop sending to recipient that
> comes from the configuration?  How else would a user override this?
>
> So I guess the topic wasn't ready for 'next' yet, after all.
>   

The same applies to the fomat.headers and format.cc config options. How
is this different?

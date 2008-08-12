From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Thunderbird: issues with applying saved patches
Date: Tue, 12 Aug 2008 14:28:46 +0200
Message-ID: <48A181FE.1030304@gmail.com>
References: <80y73kydvl.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 14:29:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSt0Y-0002iQ-9B
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 14:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbYHLM2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 08:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYHLM2r
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 08:28:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:9151 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbYHLM2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 08:28:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2257435fkq.5
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=iE2Sp/hr9w4P9o080j3wJXvA2DGroZqC012T3rxXSWQ=;
        b=QUUm9kzgvRWk9qiZs5ViHdlbNnj1AJ76a7hhAcEl2rvjq/d3hQ30uh8BtvvSb8t3b5
         SSOWG1ybHSGnlPVG7VcQXU7qT3XEbSb66pdxm2fj4IW2uY/VtONQF/+uXA2cl2h0v7lV
         16ZgLFf8b4+McrMf7DzUMJz9ab/kUsErh0Fjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=nomoyCRilsI8FVA6JwZeM5tj05QwcilvL1e2IxXUITqNR8m6VZjcPoStA6CqtExlkh
         qcjsQigzV/nPUDoO2G23vVJAvCkM3uru/LpNNUPsaKTctRgUqy2+44/Q6OJpjivVhUnb
         9WxUOqrJcTUqpvsFHBW7rYCp3dnfNDHrQUs7c=
Received: by 10.181.32.18 with SMTP id k18mr4751367bkj.96.1218544124649;
        Tue, 12 Aug 2008 05:28:44 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.192.246])
        by mx.google.com with ESMTPS id d13sm3297374fka.3.2008.08.12.05.28.42
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 05:28:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <80y73kydvl.fsf@tiny.isode.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92089>

Bruce Stephens wrote:
> Thunderbird ought to be able to save an article exactly as it is
> (it appears to be encoding it using Quoted-printable).

It seems to be saving the raw message (2.0.0.16 here, and with IMAP as
well).  If you get QP-encoded messages, check the original message with
'view source'.  Maybe your server or some program on the way is mangling
your email?

-- Lea

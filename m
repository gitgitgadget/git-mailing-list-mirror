From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Sat, 31 Jul 2010 14:54:29 -0400
Message-ID: <20100731185429.GA13309@localhost.localdomain>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
 <4C52E6E1.20101@xiplink.com>
 <vpqd3u53sd2.fsf@bauges.imag.fr>
 <4C54410B.704@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 20:54:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfHCj-000413-KZ
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 20:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157Ab0GaSyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 14:54:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39276 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab0GaSyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 14:54:35 -0400
Received: by qwh6 with SMTP id 6so729667qwh.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n7/nqiDSWXYhHyFQyzWCEXOvgX9WHxgM3EAc86C+Szo=;
        b=m/HwaQPlTPnkP7FIxqInnerUAu5Pa+P1DlYk/wQZMQzQsm6eYq9+LYFDT7auQ+GyBl
         NXF+JqgC0ZvW07+QAfbMXzxtaZUigcPJDd/E9+oWd2v6zAClh+tw++oO/sGhmJpfKxQ6
         QsfoCBmaV2x/dWc1gG8vmFe2seE8VQktF80Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EwIE4GOisSVbkfbE7j9Fb/Khqskwl3nmmYS3Z4Ea6OoH0w3dZoBgvheqXKfGCtccqE
         nnDTnyLNqM+yQX4geka8XKBEBz3w/xwuCc72+7zD4g5XbGJ46RKIvV7CyN/YB6oO0G8A
         h+OXdQPnPeWgBGbls7aAi9ik9J9vb8BOvCzcg=
Received: by 10.220.87.69 with SMTP id v5mr2393254vcl.133.1280602474156;
        Sat, 31 Jul 2010 11:54:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id m6sm1565583vcx.0.2010.07.31.11.54.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 11:54:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C54410B.704@gnu.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152335>

On Sat, Jul 31, 2010 at 05:28:11PM +0200, Paolo Bonzini wrote:
> I like run, for the short version what about ! (as in vi)?  Maybe
> with an optional space.
> 
> Paolo

I disagree. Firstly, "!" is very inconsistent with the current shorthand
forms. I think the "x" makes more since from the point of view that its
very easy to associate with exec (the first syllable is pronounced as
an "x"). "x" is also used by other commands to mean executable (for
example, "chmod +x").

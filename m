From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: failed to push
Date: Mon, 1 Mar 2010 13:27:03 -0800
Message-ID: <2793902788222999372@unknownmsgid>
References: <4B8C2E68.3020507@gnu.org>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: "bkorb@gnu.org" <bkorb@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:27:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmD94-0004Ic-89
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab0CAV1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:27:12 -0500
Received: from mail-pz0-f179.google.com ([209.85.222.179]:40736 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0CAV1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:27:11 -0500
Received: by pzk9 with SMTP id 9so2256545pzk.25
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:from:in-reply-to:mime-version:date
         :received:message-id:subject:to:cc:content-type;
        bh=h8L0umdaasJatF2/am/DGJI5UbCEu8hqc3WBD91Nryg=;
        b=i6PjOIVGJ8NHRsAe3/2Tn7op1W4SIoq9apJlT172IWttjfam/C2H6mOF1kzy1dtX1A
         BV78Caw570LZB1GYKR3rk72eMktzWIASlm8H2pSRLF/WxWIN2bjrg1l+3sg3XDsaBbki
         A+V6XUxqVsj30o8PPHyVHGMH8QeJByBvcyf4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:from:in-reply-to:mime-version:date:message-id:subject:to
         :cc:content-type;
        b=nrm1LVTK1RaqJU3CU6zUJxwRN1U3cxJbs1q4MV5EFmO7hI+qufmP2VplhOPjpKTwaA
         uf73+2O8rlU47ChhwpjkNR/AfcAfDP1BejzHLdH2bgaMk5KohIpNiPRTQ15c/Vg59uLM
         +npguuydraC9FT4/94loL2N7fjRLi/4uCBEDQ=
In-Reply-To: <4B8C2E68.3020507@gnu.org>
Received: by 10.141.124.7 with SMTP id b7mr2813897rvn.25.1267478830785; Mon, 
	01 Mar 2010 13:27:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141352>

On Mar 1, 2010, at 13:15, Bruce Korb <bkorb@gnu.org> wrote:

> Hi,
>
> This message has no meaning at all.  I know it failed to push.
> I can tell from the comment "[rejected]".  It would be nice
> to know *WHY* it was rejected so I can fix the problem.
> How do I determine the cause, please?  Thank you!!  Regards, Bruce
>
> $ git push
> To ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen
> ! [rejected]        master -> master (non-fast forward)
> error: failed to push some refs to 'ssh://bkorb@autogen.git.sourceforge.net
> /gitroot/autogen/autogen'
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

It tells you right there at the end of the rejected line. The push
would have resulted in a non-fast-forward update of the branch.

To "fix" this, you need the current commit pointed to by the branch as
one of the ancestors of the commits you're trying to push.

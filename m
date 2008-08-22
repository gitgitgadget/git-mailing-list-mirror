From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: Suggestion: "man git clone"
Date: Fri, 22 Aug 2008 17:53:45 +0200
Message-ID: <237967ef0808220853k24b2d969l55d04ec13bd7c8c9@mail.gmail.com>
References: <48ACB29C.7000606@zytor.com> <g8m6d1$7nf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:54:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWYyT-00036D-Ir
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 17:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbYHVPxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYHVPxt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:53:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:24191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYHVPxs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:53:48 -0400
Received: by ug-out-1314.google.com with SMTP id c2so167820ugf.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OusS3kYVIyYW2m5ASYhczkla9RPCkugc4jfuAuKO1GI=;
        b=GE81+SIg42FEi67JXfxQoSsEWOe758pGfvEyVCougOO860cRp+HwH8i+FafggpMjcV
         30qaarD2zcHg0fFVCwTK6NcYwGm/1+Gn4L2NZV0A+Ptl0SP4ZTGb/mZzribxa1RmA3GL
         nkoKTjlulWBZdGYXv++D2hV2dbiXMSW6kHz8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QJv+XiI2uGyS6Cd82bP/+FxjqwmTqsKBhEDuKMIksV1lkJa0j9Lg+rFhp+MxhO86Bb
         VjJRNGbke2E/c8olXBGGN0ulrKeIyiYFEOuXRswxWgObog1kACdZ2Fr9TmUTRnE1CjP0
         VA5XLgRzd2QMli2WOW7AFIOlrjScqSvFPK5/E=
Received: by 10.210.129.19 with SMTP id b19mr1655129ebd.162.1219420426278;
        Fri, 22 Aug 2008 08:53:46 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Fri, 22 Aug 2008 08:53:45 -0700 (PDT)
In-Reply-To: <g8m6d1$7nf$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93314>

2008/8/22 Michael J Gruber <michaeljgruber+gmane@fastmail.fm>:
> H. Peter Anvin venit, vidit, dixit 21.08.2008 02:11:
>> Given the recent change of "git-foo" to "git foo", it would be really
>> nice if one could type, for example:
>>
>>       man git clone
>>
>> and actually get the man page for the git clone command.  There are
>> quite a few other pieces of software which also could benefit from that
>> kind of indirection.
>>
>> Right now the above command shows the man page git(1) followed by
>> clone(2), which I believe has be classified as utterly useless behaviour...
>
> The discussion seems to show that altering man and relying on the new
> behaviour is no option, and neither is playing games with man's section
> options.
>
> How about:
>
> - Change all references in the help pages (gitlinks) accordingly.

I think that would break navigating man pages in any man reader... Most of
them detect and handle "foo(N)" magically and let you click on it.

-- 
Mikael Magnusson

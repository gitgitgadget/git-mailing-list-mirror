From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: TopGit: problem with patch series generation
Date: Tue, 12 Aug 2008 20:54:00 +0200
Message-ID: <36ca99e90808121154l1f7978a1v4de40d990005cb0e@mail.gmail.com>
References: <20080812161854.GB30067@lapse.rw.madduck.net>
	 <32541b130808120925y663967ebm38eced6df77ffe4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git discussion list" <git@vger.kernel.org>, pasky@suse.cz,
	"Manoj Srivastava" <srivasta@debian.org>,
	"vcs distro packaging discussion list" 
	<vcs-pkg-discuss@lists.alioth.debian.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:55:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSz1P-0002rb-UI
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbYHLSyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbYHLSyD
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:54:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:29952 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbYHLSyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:54:01 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1753668wxd.4
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VE1kpsA/gYG1i5Uio4mOa+Q9jiXOgQqA4STmjlMNeKk=;
        b=lTU/jg05ECTPcDLsqzkpBNTyJm5uKfOCsc25yvyOUMTy1yXslDpR8q6WRJpAO+cdlb
         Z7v0gmXKjZVU6D7k1XDEs3aEIkrP7X1uVqsN7K2bKF42gNHOPZv8gJKRMpJ3Q6PiycmP
         YP+ZlpWBko4mOtsFlfbGwf03EEZhRQGrXTU1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hw6HCb4c8NYNO4aRlSPAlDoQsaKkNINg5uXVniO91rzJ1I3rn8cqsXYfji2B2mVa4z
         em4yJh27+3TtW4jyadCOhLKOautdAs7SbLs/30ckFfStoku+2MT3OM/ClcVKRaoo6PUO
         f+44ZAa/8iXv9e7EYFU52/GeRivcKxytZKvp8=
Received: by 10.70.39.10 with SMTP id m10mr12835527wxm.41.1218567240877;
        Tue, 12 Aug 2008 11:54:00 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Tue, 12 Aug 2008 11:54:00 -0700 (PDT)
In-Reply-To: <32541b130808120925y663967ebm38eced6df77ffe4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92131>

On Tue, Aug 12, 2008 at 18:25, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Tue, Aug 12, 2008 at 12:18 PM, martin f krafft <madduck@debian.org> wrote:
>> As I am packaging TopGit for Debian, I encountered
>> the situation that two branches conflict with each other (they
>> change the same line), but there is no dependency between the
>> branches. Thus, when I squash the branches into a series, the
>> resulting patches will not apply (they both change the same original
>> line to something else).
>
> Isn't this what git-rerere is for?  If TopGit doesn't use rerere,
> maybe it would be easy to add...
I thought about this too, but have no experience with rerere.

Bert
>
> Have fun,
>
> Avery
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

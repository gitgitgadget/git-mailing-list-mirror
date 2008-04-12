From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Intricacies of submodules
Date: Sat, 12 Apr 2008 11:20:06 +0800
Message-ID: <46dff0320804112020v5488b5bbg903deba840ef468a@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
	 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
	 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
	 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
	 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
	 <1207859579.13123.306.camel@work.sfbay.sun.com>
	 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
	 <7vmyo0owep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Roman Shaposhnik" <rvs@sun.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 05:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkWIl-0002Es-JL
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 05:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758970AbYDLDUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 23:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758960AbYDLDUM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 23:20:12 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:53343 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197AbYDLDUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 23:20:10 -0400
Received: by an-out-0708.google.com with SMTP id d31so177684and.103
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c9T7njFTfMDMaHxGG2IEdiNTslEC9OtNDJ9aKfM6FQk=;
        b=Qvjih/dJzWQMdMpvSnIe+Gv2orgwsFi3lPGbDaTNxEj70bRFEHp6NRaBBeNilIECMFz9q1N+KqAYZ34I4D0HlRK1/RlDhlcCprmjDrhIPVGfgi7CM8vdWojKmdW7NmcflWVusMtq0CRHgZJZDGP16ZfuY7Srw01CHDyXOCeUtkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fCM7ValhESiUHS+sFGpQJHiQW0biJoTDtErnHq+9t5HMjOSH50zKWrW9tvhOD5KyB/tlwGYtaoN/frXf1K7utoHtdniARIZZcMJr+2oNntPzoXx4qMSYvF+4R1Pl3wKjijnF6c9748bAoNaTyWMTGsPfGAIKtTGcadgo8i+MV78=
Received: by 10.100.110.16 with SMTP id i16mr895103anc.101.1207970406349;
        Fri, 11 Apr 2008 20:20:06 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 11 Apr 2008 20:20:06 -0700 (PDT)
In-Reply-To: <7vmyo0owep.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79326>

On Sat, Apr 12, 2008 at 6:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>  > On Fri, Apr 11, 2008 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  >>  > Some of it is personal, yes. But sometimes those personal preferences
>  >>  > need to be enforced on a project level (of course, giving everybody
>  >>  > a way to override the setting if they really want to). For a big
>  >>  > software organization with a mix of senior and junior engineers I need
>  >>  > a way to set up *my* workspace in such a way that everybody who
>  >>  > clones/pulls from it get not only the source code, but also "Git best
>  >>  > practices". That would simplify things a great deal for me, because
>  >>  > I can always say: "just pull my latest .gitconfig, make sure you
>  >>  > don't have any extra stuff in your .git/confing and everything
>  >>  > in Git will work for you".
>  >>
>  >>  I think the way you stated the above speaks for itself.  The issue you are
>  >>  solving is mostly human (social), and solution is majorly instruction with
>  >>  slight help from mechanism.  The instruction "Use this latest thing, do
>  >>  not have anything in .git/config" can be substituted with "Use this latest
>  >>  update-git-config.sh which mucks with your .git/config to conform to our
>  >>  project standard", without losing simplicity and with much enhanced
>  >>  robustness, as you can now enforce that the users do not have anything
>  >>  that would interfere with and countermand your policy you would want to
>  >>  implement.
>  >>
>  > But, how  to handle the case that  there are more than one policies
>  > for different projects?
>
>  "How to"?  You would handle the case just like either of us suggested
>  above.
>
>  Are you talking about a single project with more than one policies A, B,
>  C, ... that conflict with each other?  Or are you talking about more than
>  one projects, each of which has a single project-wide policy?
>
>  I do not think the former makes sense and won't be helped with in-tree
>  file that overrides .git/config Roman discussed either.
>
>  The latter would be helped equally well whether that in-tree polic file is
>  called .gitconfig or update-git-config.sh.

I meant more than one projects, each of  which has a different
project-wide policy.  I originally thought update-git-config.sh can't
help, but i'm wrong since it can update $GIT_DIR/config instead of
$HOME/.gitconfig.

However, i think .gitconfig is better since it's more consistent with
other analogies.



-- 
Ping Yin

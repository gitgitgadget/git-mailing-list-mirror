From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Intricacies of submodules
Date: Sat, 12 Apr 2008 00:04:13 +0800
Message-ID: <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
	 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
	 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
	 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
	 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
	 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
	 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
	 <1207859579.13123.306.camel@work.sfbay.sun.com>
	 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Roman Shaposhnik" <rvs@sun.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 18:05:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkLkK-0003PV-1A
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 18:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760113AbYDKQEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 12:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760105AbYDKQEP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 12:04:15 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:53974 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760102AbYDKQEO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 12:04:14 -0400
Received: by an-out-0708.google.com with SMTP id d31so127357and.103
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Lo5nSl9oBSbqqH7U+d3LwhCgaco4rCDh8jC1Nr0EQzo=;
        b=s0tjFce3r2AeGfDM3IjYL9lgzaFPp4UpLwqVIZ5owEw1zZWLfwKf9BhV7l46ZDYz/8myR/4CJzfSIdRtjIfjzJxeVccLFqRs4+QjBJ0s9JqaIGZrvi5K2Kq7Gh8zdtc6+2AFxZ9vA9nW+FEG54T3DPGdoPphEutgeSUYoYWmTTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kE1j1pWhTfF1hKv0KMiXbPT4L3Jj5Z3pFlqOJn1LOv53a/us6A6LMD5A6dvvmV1abqd26ZIhvvU8Ch21ivd7GOTN+GUhnjwB64KR5IR41qkqCcDEVsm4X3biQumi0bdGG/JUWSEYNdyHA0TPmrQqaPKCim9kzsmhbvz39P2wCqs=
Received: by 10.100.139.20 with SMTP id m20mr5696814and.47.1207929853359;
        Fri, 11 Apr 2008 09:04:13 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 11 Apr 2008 09:04:13 -0700 (PDT)
In-Reply-To: <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79278>

On Fri, Apr 11, 2008 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  > Some of it is personal, yes. But sometimes those personal preferences
>  > need to be enforced on a project level (of course, giving everybody
>  > a way to override the setting if they really want to). For a big
>  > software organization with a mix of senior and junior engineers I need
>  > a way to set up *my* workspace in such a way that everybody who
>  > clones/pulls from it get not only the source code, but also "Git best
>  > practices". That would simplify things a great deal for me, because
>  > I can always say: "just pull my latest .gitconfig, make sure you
>  > don't have any extra stuff in your .git/confing and everything
>  > in Git will work for you".
>
>  I think the way you stated the above speaks for itself.  The issue you are
>  solving is mostly human (social), and solution is majorly instruction with
>  slight help from mechanism.  The instruction "Use this latest thing, do
>  not have anything in .git/config" can be substituted with "Use this latest
>  update-git-config.sh which mucks with your .git/config to conform to our
>  project standard", without losing simplicity and with much enhanced
>  robustness, as you can now enforce that the users do not have anything
>  that would interfere with and countermand your policy you would want to
>  implement.
>
But, how  to handle the case that  there are more than one policies
for different projects?



-- 
Ping Yin

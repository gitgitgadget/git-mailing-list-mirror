From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 09:14:43 -0700
Message-ID: <20140425161443.GE11479@google.com>
References: <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <87d2g69ekl.fsf@fencepost.gnu.org>
 <20140425154104.GB11479@google.com>
 <871twl9z8h.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 18:15:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdimA-0005wz-VX
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbaDYQOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:14:48 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:65018 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbaDYQOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:14:46 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so3313511pde.39
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mO+AiopxIVDtOou8oVZTom+H3eXVQHuYur043/gqjPg=;
        b=uMNY9wfzf5G/ARdMqN404SMb2DskkXMHTDb2HKSkPF2P+1hJHY/W3S4vYlWq5rHyti
         CjgQsPqgIdpCATuuPjyDdh218nGc1FB2AWdsGll2Fla7+9kcLLeDi/uXFcKUL4+gusqo
         MA0wZfEBodcoONxtvp4EUo2/BJA9zmekwcCL1+syy1OmeXWOW/Yjrom2S3CVjbOBwx9w
         aCXWkOfu8els6tQ+kb5un+csjR0PmGDkUxidbloYIiyQU2i3j6bydH76t2a6dFdc9Ovd
         FZcAzkdx+6OifQ0Btp14AKnhMlCygDf2hx5VYuekVOJ3J+csvYS4mSkG1pXV/FzmMtA5
         PqKw==
X-Received: by 10.66.141.144 with SMTP id ro16mr8835126pab.131.1398442485972;
        Fri, 25 Apr 2014 09:14:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gz11sm16897713pbd.1.2014.04.25.09.14.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 09:14:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <871twl9z8h.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247050>

David Kastrup wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I probably missed a subtlety, but the above comment reminded me of
>> some netiquette I think this list is starting to forget.  If I have
>> misread it, please let me know and skip the rest of this message.
[...]
>> On the git list, the rule is simple.  Feel free to grumble, but make
>> sure there is some contribution in the same message.
[...]
> Uh, Javier was commenting on a number of concrete proposals regarding
> the subject line "What is missing from Git v2.0" and quoted Felipe
> directly.  As you seem to have lost the context, let me requote the
> respective portion:

I hadn't lost the context, but thanks for a pointer.

[...]
>     = Reject non-fast-forward pulls by default =
[...]
>     The patches were sent, the issues were addressed, people agreed, and
>     yet nothing happened.
>
>     [3][4]
>
>     [...]
>
>     [3] http://thread.gmane.org/gmane.comp.version-control.git/240030
>     [4] http://thread.gmane.org/gmane.comp.version-control.git/235981

Unfortunately Felipe's summary is incomplete.

My message was meant as something that could be made into a reference
for when similar questions of netiquette come up in the future (as for
example they do all the time with Felipe).  That meant I didn't give
as good advice for your particular case than I should have.

For this particular case, my thoughts are:

If you believe those patches should be applied, please re-send them
with a summary of changes you've made (if any) and your opinion on
any unaddressed comments from the review thread.

If you believe those patches should not be applied, wouldn't it be
better to reply to that thread to help in case someone wants to pick
up the patches and fix them?

On the other hand if you just want to blow off steam, I guess that's
fine too.  Just don't expect it to result in any patches being
applied, code quality improving, etc.

Jonathan

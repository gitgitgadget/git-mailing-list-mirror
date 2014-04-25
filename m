From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 08:41:04 -0700
Message-ID: <20140425154104.GB11479@google.com>
References: <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <87d2g69ekl.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 17:41:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdiFf-0001C3-JD
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 17:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbaDYPlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 11:41:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49058 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbaDYPlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 11:41:07 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so24206pad.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vVlOICD2sbqPK6C2ZOUS+vCKSAKLce8tFLHN6NDZWTU=;
        b=rgozt96Tx/BbkFowof8e60f0gg0qBRzMr3AABUYCgT6EwiUp8LjHAY8dj7huWiT0NS
         QRjdNyU3KW+TIma8B1g6Tie/gKn18Krp6sIZxycafuTrgvCjAKBiNkmG/hj5v4buezgr
         bDJ5X0rao0PyaUT9iDCE3L0yMFON7UX9HKaZALvocE5PoKyZFLAw3wxs7HLyxDeNrLG6
         XTAa+o0/fuyG3z//Ev7M2kpZoJd81jQ2M4V80bLQfsYuLBnkaODah3ZULIUUKu+73bme
         WTCFR+6a9BNSs1DTyXv0gOkS7XzKmJ1+EYXW0S18KQfZDSeB1YJF/9aobY6kBTosfEvY
         tLkQ==
X-Received: by 10.68.163.197 with SMTP id yk5mr8599770pbb.57.1398440467250;
        Fri, 25 Apr 2014 08:41:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id hb10sm16646311pbd.75.2014.04.25.08.41.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 08:41:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87d2g69ekl.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247046>

Hi,

David Kastrup wrote:
> Javier Domingo Cansino <javierdo1@gmail.com> writes:

>> = Reject non-fast-forward pulls by default =
>> Not having this introduced yet allows newbie people to use git with
>> just 4 commands, without bothering around with fetch and merge and so.
>
> If you have a gun lying around your house, you should turn the safety
> catch off or the children will not be able to use it without
> instruction.

I probably missed a subtlety, but the above comment reminded me of
some netiquette I think this list is starting to forget.  If I have
misread it, please let me know and skip the rest of this message.

This is a comment about style, not substance.  Like coding style,
discussion style matters as a way of making life easier for
maintainers and new contributors, and different projects have subtly
different practices.

On the git list, the rule is simple.  Feel free to grumble, but make
sure there is some contribution in the same message.  For example,
after the confusing gun analogy you can say "How about this patch?"
and people reading can follow up by reviewing that patch and
potentially getting it applied.

"But what if there's already a patch doing what I want to do?" you
might ask.  No problem.  Link to the patch and say "I think this patch
should be revisited", or even better, re-send it with some notes about
how previous review comments have been addressed or remain to be
addressed.

"How do I get feedback on design of a new change without wasting a lot
of time coding something that might be a bad idea?"  Glad you asked.
Sometimes instead of a patch, a better contribution is a detailed
explanation of a design to be reviewed and adopted.  In this case, do
try to be clear about whether you'll have enough time to implement the
result or will be relying on others so people know how much time to
devote to working out the details.

"What about feature requests?  I might have an idea for improving git
that no one's had before but I don't have a detailed design in mind."
Sure, that can be a good contribution.  Just treat it as a gift ---
don't assume anyone is going to implement it for you if they're not
interested.

"What about reminders about known bugs?  There's this regression and
it would not be right to release without fixing it but I think it's
fallen through the cracks."  Yes, good contribution.

"What about jokes?"  Sure, making people laugh is productive.

"What about cryptic grumbling?"  Sorry, unless you are grumbling to
get input on how to improve git's documentation or code, it's not
enough to be worth sending an email to this list.

Hope that helps,
Jonathan

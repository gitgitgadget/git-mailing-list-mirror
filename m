From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Wed, 21 Jan 2009 23:19:11 +0200
Message-ID: <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
	 <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkV6-0001mZ-6l
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbZAUVTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbZAUVTO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:19:14 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:61786 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbZAUVTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:19:14 -0500
Received: by ewy13 with SMTP id 13so1913198ewy.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 13:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LqDDhXnVRD5cUDvA7xvy6AEyq6zqM3/thGqGD9EmodI=;
        b=ZnTT8hmyo47pkoZwJHqxVruZ/Bk++b+9xcr8ggkFNRCBA9uybmD/fYYbnsoUgFAu4S
         UQnLNy66wvI9I1DZn58sDty1RlTkwMgyTA7eZQr6iLxS+gWd11lvUrRGf7r8T9b9TX0v
         MlYto3n6f9CIyGCptT0NlmcRUFea1fjucF/d8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=poIePVWxSdxDSuPhIbaK1SEEFbC9jkyX4LLaNBxSiW2MaXRfe9ZQs4iUcnEDzSNiOc
         mTYA+80+7KAfIupSQMZqOOX0Pa1hvu9Qrn1LJSf1gbZp0wVA8zdqlsBXh5oWV3g87eMp
         dWJanLTS6lMXNk5lmTBeELyp3OVULu1v3ReRU=
Received: by 10.86.65.9 with SMTP id n9mr351943fga.61.1232572751432; Wed, 21 
	Jan 2009 13:19:11 -0800 (PST)
In-Reply-To: <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106675>

On Wed, Jan 21, 2009 at 10:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This is shorter, avoids the burder to think about the format of the
>> configuration file, and git config is already used in other places in
>> the manual.
>
> I am moderately against changing this part to use "git config".
>
> We traditionally introduced how to set configuration variables first by
> editing it in an editor, and this was quite deliberate, in order to show
> how the configuration file looks like, to demonstrate that there is no
> deep magic in the file format, and to explain that it is perfectly Ok to
> edit it without using "git config" command.
>
> I actually wish this section appeared a lot earlier in the document, but
> that is a separate issue.

I agree that it's good that people get familiar with the config
format, and that it should appear earlier in the document, perhaps as
a separate section. However, for new users that just want to get
started any extra burden weighs in the misconception that git is not
user friendly.

I read the comments in both threads Jeff pointed out and I have
comments regarding the argument that it's easy to edit a text file.

It's easy to *change* a text file, not so much to write something by
hand. Although the user would probably just copy-paste the text from
the online manual (changing spaces by a tag in the process) there's a
possibility that the manual is printed.

This brings back my previous question: where is the home directory in
a Windows system?

An idea would be to add an --edit option to git config, so the users
don't need to care about the location of the text file and just do
"git config --global --edit" which would bring the editor. Although
I'm not sure how that would work on Windows since the editor is
probably not properly configured at that point.

Now, *nobody* has replied back the comments of providing both the git
config command and .gitconfig snip. It was mentioned in both threads
and ignored.

Anyone against that?

-- 
Felipe Contreras

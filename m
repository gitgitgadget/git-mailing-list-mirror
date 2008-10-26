From: Brandon <siamesedream01@gmail.com>
Subject: Re: From Perforce to Git
Date: Sun, 26 Oct 2008 11:08:27 -0500
Message-ID: <82c87da00810260908w2530dbb8j7ebcabe2516d5ed@mail.gmail.com>
References: <82c87da00810251418y4a6ef1fbgccefb12061535226@mail.gmail.com>
	 <ee77f5c20810251640q4b40d524n7271a0dfa11ebef8@mail.gmail.com>
	 <ee77f5c20810251641l4892ff12n7b30667c6fcc903c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 17:10:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku8Bs-0006Pr-LK
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 17:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbYJZQI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 12:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755630AbYJZQI3
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 12:08:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:49178 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691AbYJZQI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 12:08:28 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1721292rvb.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GqQ5VpFG9C0FklyMEsIEjgQxBb3b4+NUksDVzAPNVbo=;
        b=lZYwctrztcW3V32o6whvFspfwoq+EZre5snar4brRgOidNnabKsw7AO91dk27GD5z1
         wO60wpv2SFfNhZm3fARuoBLFQgASjz/Gs45IT9pM6CY3Ky0g6OC8leG4Ij78844/jUIz
         iBNvneVKjsNQqrYIhLKVP3/756JbFRL78fbU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=B/q1yUw0JPxjoFii1UcMo8r3o8QE7P9sx2g0/Lc8K4PvzZfT2paU7s7IJmX8bIhVBP
         XBnrI2jXJV8DVI/kquCnFA0fRw2ct7F6K9hgX/J7j32w0vO0d87CV4l0+V4FrqfnWpOy
         JPtXcEGZtimz6doH2bbTF4txBj7W61PhsmQJg=
Received: by 10.140.188.10 with SMTP id l10mr2657387rvf.6.1225037307313;
        Sun, 26 Oct 2008 09:08:27 -0700 (PDT)
Received: by 10.141.79.18 with HTTP; Sun, 26 Oct 2008 09:08:27 -0700 (PDT)
In-Reply-To: <ee77f5c20810251641l4892ff12n7b30667c6fcc903c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99170>

On Sat, Oct 25, 2008 at 6:41 PM, David Symonds <dsymonds@gmail.com> wrote:
> On Sat, Oct 25, 2008 at 2:18 PM, Brandon <siamesedream01@gmail.com> wrote:
>
>>   I'm trying to make a comprehensive comparison of Perforce and Git
>> features. There are two things I currently can't find:
>>
>> 1) "Who's editing what"
>>    It's been documented that git can help developers communicate who
>> is editing what at any given time like perforce. (assuming there is a
>> central repositry) Has anyone seen an example of scripts to do this?
>
> That's the primary feature of Perforce that kills its scalability once
> you get past a few hundred developers; it bloats the metadata too
> much. When you're using Git, there's really little point in using it,
> since you don't declare what files you are going to be editing, and
> you can find out other people's changes at merge time at your leisure
> (not just when *you* want to commit).

   I think there is an even more fundamental problem with this
feature. Since perforce 'forces' developers the checkout files for
edit, eventually you just ignore these warnings because you don't know
if someone is really checking something out to make a change they are
going to commit, or just need to make a file writable to experiment
with some other feature they're working on etc... This feature would
work much better if it were optional. I don't really care about the
feature per se I would just like to be able to state that Git can
offer everything that perforce can.
   I would imagine this would require users pushing their changes to a
branch in the central git repo. Then other users could use git log or
cherry to see what files others are interested in (aka declared they
are going to edit)? Not that this is necessarily a good way to work.


>> 2) Symlinks to checkout partial repository
>>   I believe I read symlinks could be used to checkout part of a
>> repository. Is this true? any references? I imagine submodules is the
>> preferred way of doing this, and "narrow" or "partial" or "sparse"
>> checkouts are under development
>
> I don't think so. You could use symlinks to *simulate* a bigger
> repository that is actually made up of smaller repositories.
>
>
> Dave.
>

thanks, I'm pretty sure I'm just imagining reading this somewhere, I
just needed some confirmation.

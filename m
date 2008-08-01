From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Fri, 01 Aug 2008 13:06:34 +0200
Message-ID: <4892EE3A.3040108@lyx.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>	 <20080729170955.GK32184@machine.or.cz>	 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>	 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>	 <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>	 <alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>	 <7vy73j418t.fsf@gitster.siamese.dyndns.org> <4891A0D0.6060503@lyx.org>	 <20080731225703.7be6f76e@neuron> <4892C042.20302@lyx.org> <37fcd2780808010345l755b83a5gff8a5aa350016ad5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 13:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOsU7-0007Sz-MH
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 13:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbYHALGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 07:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbYHALGn
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 07:06:43 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:38090 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbYHALGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 07:06:42 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 3AF69B01F4;
	Fri,  1 Aug 2008 13:06:41 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 0D8DFB0201;
	Fri,  1 Aug 2008 13:06:40 +0200 (CEST)
User-Agent: Thunderbird/3.0a2pre (Windows; 2008072800)
In-Reply-To: <37fcd2780808010345l755b83a5gff8a5aa350016ad5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91055>

Hi Dimitry,

Dmitry Potapov wrote:
>  On Fri, Aug 1, 2008 at 11:50 AM, Abdelrazak Younes <younes@lyx.org>
>  wrote:
> > AsciiDoc is indeed excellent if you want to write in a plain text
> > editor. But LyX is easier to use and more porwerful :-)
>
>  What is really powerful is TeX. As to LyX, it is leaky abstraction
>  over it. I have never been able to use without ending up saying, it
>  is so much easier and much more powerful to use Latex than trying to
>  do the same with LyX. Of course, LyX looks much better nowadays than
>  used to be, so I decided to give it another try, and here is my
>  fifteen minutes experience with it.

I was afraid this thread will turn into a pro and con of LyX versus 
plain LateX :-)


>  First, I tried to open FAQ.lyx that you attached to your previous
>  email, and here is what I see:
...
>  Now, I see, that your FAQ was created with LyX 1.6.0svn, which is not
>  released yet. So, I hope that this issue will be correctly before it
>  will be released.

Of course. Sorry, as I use the pre-release I didn't think that about 
that. FYI, we will release one last version of 1.5.x that is able to 
read 1.6 format. 1.6 will is of course able to read all previous format.

>  Otherwise, anyone opening document with 1.6.0 will make it
>  unaccessible to users of previous versions.
>
>  Then I tried to use Formatted reference and everything looks okay
>  until I tried to generate DVI file, where I was welcome but the
>  following error: === Paragraph ended before \@prettyref was
>  complete. ===
>
>  What is \@prettyref? What is wrong with my paragraph? Actually, my
>  paragraph is fine, it is just when you use Formatted reference, you
>  should know that it is implemented using prettyref TeX package, which
>  requires three letter prefix in name of each label. Why did not LyX
>  warn me about that? BTW, is really prettyref is the best package for
>  this job anyway? I remember some TeX experts recommended some other
>  packages for references.

Aha, yes you're right. LyX will automatically insert those three letters 
(eg. 'cha' for chapter). This is the reason why I never came across this 
bug. We'll try to fix that, thanks!

>
>  Finally, I still have not figured out how to the same what AsciiDoc
>  does: Chapter #, $CHAPTER_NAME It does not look like that LyX can
>  produce references in this format.

You can choose among a number of document class. If you want the 
"Chapter" prefixing, choose the 'Book' document class. The default,  
document class is 'Article', for with you don't have level 1 sections.

>  The I tried to insert some verbatim text, and I cannot find the
>  standard way to do that in LyX.

There are at least two:
- The LyX-code environment
- The listing inset

The listing inset supports a number of languages so you'll be able to 
have syntax highlighting and cloring for your language of choice.

>  Sure, I can press CTRL-L and type in
>  TeX: \begin{verbatim} # git itself (approx. 10MB download): $ git
>  clone git://git.kernel.org/pub/scm/git/git.git # the linux kernel
>  (approx. 150MB download): $ git clone
>  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>  \end{verbatim}
>
>  but I don't think that having a lot TeX code is going to help us
>  with having good formatted HTML version.

No, either LyX-code (To choose from the Layout combo box) or preferable 
the Listing inset (Menu Insert -> Program Listing). Of course, all these 
action have keyboard shortcuts.

>
>  BTW, it is really annoying to see TeX code displayed in proportional
>  fonts and formatted with full adjustment. For instance, the last
>  line was displayed like this:
>
>  $                               git
>  clone
>  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Yes I know, this will be better in 1.6 due out this month in principle.

>  Another rather surprising experience for those who got used to HTML:
>  Left-click on a reference produces its properties, while the right
>  click means to go to the label, and once you jump on it, there is no
>  way to jump back (at least, I was not able to find how to do that).

There is one 'Ctrl-0' but this is more or less hidden feature. 1.6 will 
have context menu so all the above actions will be a lot more consistant 
and easier.

>  Well, I wrote all above only because I hope that LyX will continue
>  to improve. It looks much better now than before.

Thanks for the comments :-)

>  Yet, I will rather
>  stay with plain text editors for now. Some of them are much more
>  powerful than Notepad :)

It's a matter of choice. I have to confess that I don't use plain text 
editor anymore because I am so used to LyX keybindings.

Thanks,
Abdel.

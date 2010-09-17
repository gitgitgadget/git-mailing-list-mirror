From: clemens fischer <ino-news@spotteswoode.dnsalias.org>
Subject: Re: Reply-to-all when using gmane's web interface
Date: Fri, 17 Sep 2010 20:26:07 +0200
Message-ID: <veocm7xqu5.ln2@nntp.spotteswoode.dnsalias.org>
References: <4C74194B.6080306@nextest.com> <20100825005959.GB10423@burratino>
	<4C74E890.90900@nextest.com> <20100825223024.GB2850@burratino>
Cc: git@vger.kernel.org
To: gmane-discuss@hawk.netfonds.no
X-From: gmane-discuss-bounces@hawk.netfonds.no Fri Sep 17 21:30:08 2010
Return-path: <gmane-discuss-bounces@hawk.netfonds.no>
Envelope-to: gd-gmane-discuss@m.gmane.org
Received: from hawk.netfonds.no ([80.91.224.246])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <gmane-discuss-bounces@hawk.netfonds.no>)
	id 1OwgdM-0001Lb-5p
	for gd-gmane-discuss@m.gmane.org; Fri, 17 Sep 2010 21:30:08 +0200
Received: from localhost ([127.0.0.1] helo=hawk.netfonds.no)
	by hawk.netfonds.no with esmtp (Exim 3.36 #1 (Debian))
	id 1OwgdM-0004qM-00; Fri, 17 Sep 2010 21:30:08 +0200
Received: from lo.gmane.org ([80.91.229.12])
	by hawk.netfonds.no with esmtp (Exim 3.36 #1 (Debian))
	id 1OwgdK-0004qH-00
	for <gmane-discuss@hawk.netfonds.no>; Fri, 17 Sep 2010 21:30:06 +0200
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gd-gmane-discuss@m.gmane.org>) id 1OwgdH-0001Gn-PW
	for gmane-discuss@hawk.netfonds.no; Fri, 17 Sep 2010 21:30:03 +0200
Received: from 95-89-61-84-dynip.superkabel.de ([95.89.61.84])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <gmane-discuss@hawk.netfonds.no>; Fri, 17 Sep 2010 21:30:03 +0200
Received: from ino-news by 95-89-61-84-dynip.superkabel.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <gmane-discuss@hawk.netfonds.no>; Fri, 17 Sep 2010 21:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: gmane-discuss@hawk.netfonds.no
Followup-To: gmane.discuss
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 95-89-61-84-dynip.superkabel.de
Cancel-Lock: sha1:txEI0wKNx6F8lcJx1xT0vB+kbCs=
X-Archive: encrypt=none
Mail-Copies-To: nobody
User-Agent: tin/1.9.6-20100313 ("Lochruan") (UNIX) (Linux/2.6.35.4-spott
	(i686))
X-BeenThere: gmane-discuss@hawk.netfonds.no
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: gmane-discuss.hawk.netfonds.no
List-Unsubscribe: <http://hawk.netfonds.no/cgi-bin/mailman/listinfo/gmane-discuss>,
	<mailto:gmane-discuss-request@hawk.netfonds.no?subject=unsubscribe>
List-Archive: <http://hawk.netfonds.no/pipermail/gmane-discuss>
List-Post: <mailto:gmane-discuss@hawk.netfonds.no>
List-Help: <mailto:gmane-discuss-request@hawk.netfonds.no?subject=help>
List-Subscribe: <http://hawk.netfonds.no/cgi-bin/mailman/listinfo/gmane-discuss>,
	<mailto:gmane-discuss-request@hawk.netfonds.no?subject=subscribe>
Sender: gmane-discuss-bounces@hawk.netfonds.no
Errors-To: gmane-discuss-bounces@hawk.netfonds.no
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156411>

(sorry to be late)

On Thu-2010/08/26-00:30 Jonathan Nieder wrote in gmane.discuss:

> (+cc: git@, gmane-discuss@)

f'up set to gmane.discuss.

> At any rate, here is my current (cumbersome) strategy for replying
> to a message from the web archive.
> 
> 1. Find the message (in the classic news.gmane.org view).
> 
> 2. Click the subject in the upper pane.  The message shows up
>    in the lower pane.
> 
> 3. Click the subject in the lower pane.  Now the upper pane
>    shows the relevant thread.
> 
> 4. Examine the URL:
>    http://thread.gmane.org/gmane.comp.version-control.git/154241/focus=154296
>    Where n is the number after "focus=", rewrite it to
>    http://download.gmane.org/gmane.comp.version-control.git/<n>/<n + 1>
> 
> 5. Download that message:
>    $ wget http://download.gmane.org/gmane.comp.version-control.git/154296/154297
> 
> 6. Open in mail client and reply as usual.
>    $ mutt -f 154297

I know of a patch to mutt allowing to access NNTP servers directly.  In
general, I don't know why people would want to use anything but NNTP to
access gmane.org.


clemens

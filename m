From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Fri, 20 Jul 2007 11:34:50 -0700 (PDT)
Message-ID: <772058.65660.qm@web38907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 20:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBxJm-0001Ep-Qb
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 20:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761116AbXGTSez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 14:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757576AbXGTSex
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 14:34:53 -0400
Received: from web38907.mail.mud.yahoo.com ([209.191.125.113]:44605 "HELO
	web38907.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752258AbXGTSev (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 14:34:51 -0400
Received: (qmail 65934 invoked by uid 60001); 20 Jul 2007 18:34:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=0vz+eO9eir2h7AjBHgQSrenoCjR+kO2GWZC/7SLCFEINNP/cybf5o1IH82Le5rKH9CnQjAueHXFDDS4Q65Y2xS9lIfBEXTcMbCKop43obkPhAZAx7UfpzQuZMmOWM2ufw+sb+uinUq802QBOJgWQiiyh1Z5PftvjaqKO/BTqnOg=;
X-YMail-OSG: Y4xJ3FkVM1lvHpgr_TmRLrufHlb_4XAqiA0NNb6ybuJTWruJ84Pu9cifRqSgA_EKcL3mpIz8yMj2TOF0lAyocKWvIphKGdTw0o3GDoGV6u.3lCE-
Received: from [128.251.102.158] by web38907.mail.mud.yahoo.com via HTTP; Fri, 20 Jul 2007 11:34:50 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53110>

After the glossary of terms has been create, it is easy to create the catalog file (assuming we use Tcl's standard mechanism). Each locale should have it's own file, named <locale_name>.msg (for example, es.msg for spanish). Inside that file, you just create entries for each glossary term (the below assumes that the msgcat namespace was imported):

  mcset es Hello Hola
  mcset es "Hello %s" "Hola %s"
    .
    .
    .

You can find more out here if you like http://wiki.tcl.tk/msgcat

HTH,
    --brett


----- Original Message ----
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Shawn O. Pearce <spearce@spearce.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>; Christian Stimming <stimming@tuhh.de>; git@vger.kernel.org
Sent: Friday, July 20, 2007 10:32:24 AM
Subject: Re: [PATCH] Internationalization of git-gui

On 7/20/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 19 Jul 2007, Christian Stimming wrote:
> >
> > > Does this implementation look okay?
> >
> > This is valuable work, but unfortunately, it does not follow the
> > recommendation in Documentation/SubmittingPatches at all.
> >
> > For starters, please send the patches inlined, one per mail.  And you
> > might want to Cc the maintainer of git-gui (Shawn Pearce), too...
>
> I agree that internationalization of git-gui is worth doing.
> I've thought about working on it, but haven't yet because nobody
> else has seemed interested in having it done.  Apparently someone
> is, so patches towards that end are most welcome.

Hi Shawn,
I volunteer to translate all the git-gui messages in Italian.

Just let me if you are interested and please give me an hint on how to
produce the translation so that you can incorporate it.

Thanks.

Regards,

-- 
Paolo
"Tutto cio' che merita di essere fatto,merita di essere fatto bene"
Philip Stanhope IV conte di Chesterfield
-
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html





       
____________________________________________________________________________________
Yahoo! oneSearch: Finally, mobile search 
that gives answers, not web links. 
http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC

From: Marco Costalba <mcostalba@yahoo.it>
Subject: ANNOTATION in qgit-0.95
Date: Sun, 25 Sep 2005 12:50:41 -0700 (PDT)
Message-ID: <20050925195042.41928.qmail@web26308.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 21:52:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJcWl-0000T3-ST
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 21:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVIYTuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 15:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVIYTuv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 15:50:51 -0400
Received: from web26308.mail.ukl.yahoo.com ([217.146.176.19]:10896 "HELO
	web26308.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932282AbVIYTuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 15:50:51 -0400
Received: (qmail 41930 invoked by uid 60001); 25 Sep 2005 19:50:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=b6uIKG2+m37/npv0NYqPl+bwJKURKZ8jAPxBJ/L8HR2WrtUVJk7xmB5+Cmn8iOmK8xOIucGnBb1/Fz3v3qGqBqpBhcVZzjTVGYbYvUkU0YaccdJDYB4JFbbtgXp/q4SXCHV0z7OOAvNHZ/33ZRZf2fpOfBX2w3nw71wa6Pj6QSY=  ;
Received: from [151.42.224.4] by web26308.mail.ukl.yahoo.com via HTTP; Sun, 25 Sep 2005 12:50:41 PDT
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9282>

Petr Baudis wrote:

I thought about your feedback on annotation:
>
>* Clicking on the file was supposed to bring some annotated view, but if
>it is so, it should write "Annotate" in the window title, and should
>indicate that it is computing it on the background (and is really slow
>in that, or I don't know, but always only single revision was shown
>there). It is unclear what the "pin file" checkbox is supposed to mean,
>and the whole dialog is just very confusing. :-)
>

and I think you peraphs have the flag 
edit->settings->general->'load file names in background' unset.

Currently annotation filters out file history looking only at loaded file names, so no file names
means no annotation and this could explaing what you have seen.

Make annotation working also without file names loaded is on my TODO list, in the meantime,
you should need to set the flag and eventually refresh (F5), before to try annotate.

It's my bad I didn't documented properly this requirement.

Indeed the flag 'load file names in background' _should_ always be set.
 
You need to unset the flag only for very very big archives like the whole 
linux history tree (kernel.org:/pub/scm/linux/kernel/git/tglx/history.git) so to keep
memory requirement at a minimum.

Please, let me know if this clears the things a bit.


Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

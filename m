From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-options: add --patch-with-stat
Date: Sat, 15 Apr 2006 13:56:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604151353580.25324@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604151340210.24303@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550604150450u37ce1660u2db4f6e97c586e13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 13:56:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUjOB-0005lZ-De
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 13:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWDOL42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 07:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWDOL41
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 07:56:27 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52691 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932499AbWDOL41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 07:56:27 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 328B41C51;
	Sat, 15 Apr 2006 13:56:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 274201C2C;
	Sat, 15 Apr 2006 13:56:23 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 0A30E1120;
	Sat, 15 Apr 2006 13:56:22 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550604150450u37ce1660u2db4f6e97c586e13@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18742>

Hi,

On Sat, 15 Apr 2006, Marco Costalba wrote:

> On 4/15/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> >         BTW I really would like to have a diffstat for combined diffs.
> >         Any ideas?
> 
> Well..hem..why do not count the (shifted) + and - in the combined diffs 
> ouput?

This does not help. The combined diff is so useful, because it contains 
the information as to which parent has this difference, and which parent 
has not.

By just counting the plusses and minusses, this information is filtered 
out.

Ciao,
Dscho

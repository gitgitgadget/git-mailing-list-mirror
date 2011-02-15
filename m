From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Tue, 15 Feb 2011 11:19:26 +0100
Organization: Bertin Technologies
Message-ID: <20110215111926.5fdafa1d@chalon.bertin.fr>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <20110207091740.GA5391@elie> <20110207095713.GA19653@do>
 <7v1v3jvaef.fsf@alter.siamese.dyndns.org>
 <AANLkTim_G9cPs=+1GQ2qBEgriOyKYgXk17iHE4oq9h2C@mail.gmail.com>
 <20110208043000.GA6375@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 11:35:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpIFP-0001y4-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 11:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab1BOKfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 05:35:01 -0500
Received: from blois.bertin.fr ([195.68.26.9]:60742 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab1BOKe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 05:34:59 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 48A9E542A6
	for <git@vger.kernel.org>; Tue, 15 Feb 2011 11:34:59 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 0C5C7542AF
	for <git@vger.kernel.org>; Tue, 15 Feb 2011 11:34:58 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LGN008O6MQA5780@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 15 Feb 2011 11:34:58 +0100 (CET)
In-reply-to: <20110208043000.GA6375@elie>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.5.0.1024-17956.006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166835>

On Mon, 07 Feb 2011 22:30:00 -0600
Jonathan Nieder <jrnieder@gmail.com> wrote:
> For storage of empty subtrees in repos imported from svn, Yann's idea
> of using .gitattributes somehow (maybe in the parent directory or
> maybe in the subdir itself) seems oddly appealing.

In fact, I was mostly thinking about only using the
toplevel .gitattributes, if only to avoid the same sort
of clutter caused by the .gitignore-trick.

-- 
Yann Dirson - Bertin Technologies

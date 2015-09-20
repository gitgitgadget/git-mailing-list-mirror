From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Sun, 20 Sep 2015 13:36:26 +0000
Message-ID: <1442756186.4802.5.camel@transmode.se>
References: <1440157010.1759.83.camel@transmode.se>
	 <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
	 <1442245035.10125.18.camel@transmode.se>
	 <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
	 <1442508864.21964.26.camel@transmode.se>
	 <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
	 <b80246c46079167db6f90ee70de4368b@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
	"pclouds@gmail.com" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 15:36:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdenF-00063o-80
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 15:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbbITNgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 09:36:32 -0400
Received: from smtp.transmode.se ([31.15.61.139]:62640 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755207AbbITNgb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Sep 2015 09:36:31 -0400
Received: from exch2.transmode.se (exch2.transmode.se [192.168.203.24])
	by smtp.transmode.se (Postfix) with ESMTP id 56FEA1186FD9;
	Sun, 20 Sep 2015 15:36:27 +0200 (CEST)
Received: from exch1.transmode.se (192.168.201.16) by exch2.transmode.se
 (192.168.203.24) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Sun, 20 Sep
 2015 15:36:26 +0200
Received: from exch1.transmode.se ([fe80::3029:ce14:7d42:cc5]) by
 exch1.transmode.se ([fe80::3029:ce14:7d42:cc5%17]) with mapi id
 15.00.1076.000; Sun, 20 Sep 2015 15:36:26 +0200
Thread-Topic: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Thread-Index: AQHQ3AWr4MUVkjVcJE+EJNOGRY0lNp4lzPKAgBZf8YCABJAwgIAAPF0AgAIw4oCAAFFygIAB/VsA
In-Reply-To: <b80246c46079167db6f90ee70de4368b@dscho.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.16.5 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.200.4]
Content-ID: <EE785C330EAD954893A73838AD31EB2C@transmode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278241>

On Sat, 2015-09-19 at 09:13 +0200, Johannes Schindelin wrote:
> Hi Duy,
> 
> On 2015-09-19 04:21, Duy Nguyen wrote:
> > On Thu, Sep 17, 2015 at 11:54 PM, Joakim Tjernlund
> > <joakim.tjernlund@transmode.se> wrote:
> > > On Thu, 2015-09-17 at 20:18 +0700, Duy Nguyen wrote:
> > > > On Mon, Sep 14, 2015 at 10:37 PM, Joakim Tjernlund
> > > > <joakim.tjernlund@transmode.se> wrote:
> > > > > On Mon, 2015-08-31 at 16:56 +0700, Duy Nguyen wrote:
> > > > > > On Fri, Aug 21, 2015 at 6:36 PM, Joakim Tjernlund
> > > > > > <joakim.tjernlund@transmode.se> wrote:
> > > > > > > I cannot push:
> > > > > > > # > git push origin
> > > > > > > Login for jocke@git.transmode.se
> > > > > > > Password:
> > > > > > > Counting objects: 7, done.
> > > > > > > Delta compression using up to 4 threads.
> > > > > > > Compressing objects: 100% (7/7), done.
> > > > > > > Writing objects: 100% (7/7), 13.73 KiB | 0 bytes/s, done.
> > > > > > > Total 7 (delta 4), reused 0 (delta 0)
> > > > > > > fatal: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR':
> > > > > > > Permission
> > > > > > > denied
> > 
> > I'm about to do it, but now I'm not sure if I should move
> > shallow_XXXXXX out of $GIT_DIR. It will not be the only command that
> > may write to $GIT_DIR. "git gc --auto" (which can be triggered at the
> > server side at push time) can write $GIT_DIR/gc.pid (and soon,
> > gc.log). Even if you disable gc --auto and run it periodically (with
> > cron or something), it will write gc.pid.
> > 
> > Is it really necessary to remove write access in $GIT_DIR? Do we (git
> > devs) have some guidelines about things in $GIT_DIR?
> 
> IMO it makes little sense to remove write access from users who you want to push.
> 
> They need to write objects to the directory, after all, and update refs.
> 
> This problem sounds more like the doing of an overzealous sysadmin to me than a careful one who researched
> diligently what locations require write access for the intended operations.

We did and it all worked just fine , uses can push as they should. It is just shallow clones
that are non working. Why are pushes against normal clones and shallow clones not handled the
same way w.r.t tmp file creation?

> 
> Personally, I see little sense in bending over to try to support such an intentionally tampered setup.

Before bringing out your shootgun, make sure you are aiming it the right target.

 Jocke

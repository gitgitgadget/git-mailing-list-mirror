From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v2] Documentation/urls: Rewrite to accomodate
 <transport>::<address>
Date: Mon, 5 Apr 2010 01:33:34 +0300
Message-ID: <20100404223334.GA23049@LK-Perkele-V2.elisa-laajakaista.fi>
References: <f3271551003290959v263fe04bt1047f390788916c2@mail.gmail.com>
 <k2hf3271551004041227sfade965aubb4273a6340b7518@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 00:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyYOe-0002jp-D4
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab0DDWeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 18:34:20 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:47720 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab0DDWeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:34:19 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id D69D5C7A85;
	Mon,  5 Apr 2010 01:34:17 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A059BBD174A; Mon, 05 Apr 2010 01:34:17 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 39A2E1C6382;
	Mon,  5 Apr 2010 01:34:09 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <k2hf3271551004041227sfade965aubb4273a6340b7518@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143958>

On Mon, Apr 05, 2010 at 12:57:13AM +0530, Ramkumar Ramachandra wrote:
> On Mon, Mar 29, 2010 at 10:29 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
> > Rewrite the first part of the document to explicitly show differences
> > between the URLs that can be used with different transport
> > protocols. Mention <transport>::<address> format to explicitly invoke
> > a remote helper.
> 
> Could someone remote helper experts kindly review/ ack this?

Some things from quick reading.

<transport>://<something> also requests transport helper remote-<transport>
if <transport> is not known internally. Then there is ftp and ftps...

-Ilari

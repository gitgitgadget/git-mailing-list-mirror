From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Fri, 8 May 2015 22:03:41 -0400
Message-ID: <20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
 <CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 09 04:04:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqu7c-0005Av-SG
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 04:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbbEICD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 22:03:58 -0400
Received: from tbsaunde.org ([66.228.47.254]:41354 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbbEICD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 22:03:57 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 277A2C072;
	Sat,  9 May 2015 02:03:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268691>

On Fri, May 08, 2015 at 05:29:42PM -0700, Stefan Beller wrote:
> On Fri, May 8, 2015 at 4:46 PM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
> > its rather silly especially considering the next line contains the
> > full hash again.
> 
> Maybe we can omit it altogether then?

SO we'd print something like

the first bad commit is
Commit abcdefabcdefabcdefabcdefabcdefabcdefabcd
Author foo@ba.com

blah blah blah

? That seems reasonable to me.  If we're going that far does it also
make sense to drop printingthe lines about which trees have changed and
just print the commit message / author / hash?

Trev

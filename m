From: Max Kirillov <max@max630.net>
Subject: Re: git gui crashes ( v 1.8.5.2)
Date: Tue, 14 Jan 2014 08:50:14 +0200
Message-ID: <20140114065014.GA29816@wheezy.local>
References: <CANJSc_uYm7f4LoZoMoVzcsmGrYnUy+2nXFL_cNWqQnwLb5J6mw@mail.gmail.com>
 <20140114011141.GF18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Beno=C3=AEt_Bourbi=C3=A9?= <benoit.bourbie@gmail.com>,
	git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 07:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2xxJ-00037H-DW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 07:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbaANG61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jan 2014 01:58:27 -0500
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:60547
	"EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752322AbaANG6N (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 01:58:13 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2014 01:58:13 EST
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa09-04.prod.phx3.secureserver.net with 
	id DiqC1n00P4CavkR01iqMF8; Mon, 13 Jan 2014 23:50:22 -0700
Content-Disposition: inline
In-Reply-To: <20140114011141.GF18964@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240391>

Hi.

On Mon, Jan 13, 2014 at 05:11:41PM -0800, Jonathan Nieder wrote:
> (just cc-ing some area experts)
> Beno=C3=AEt Bourbi=C3=A9 wrote:
>> git gui crashes on my Linux machin since I updated it to 1.8.5.2.

I believe this happens at tk8.4 or earlier. I have not
tested it there, and according to the manpages in Internet
the older versions do not have the -stretch option.

Before I can find a system to test it, I think the panned
right half should really be reverted for the older versions of
tk. I remember it did not behave correctly without the
stretch option.

Maybe, to avoid cluttering the code, panedwindow should nit
be used at all without the ttk.

I'll try to submit a fix today.

--=20
Max

From: Holger =?iso-8859-1?Q?Wei=DF?= <holger@CIS.FU-Berlin.DE>
Subject: Re: [PATCH] Link against libiconv on IRIX
Date: Mon, 5 Apr 2010 21:44:54 +0200
Organization: Freie =?iso-8859-1?Q?Universit=E4t?= Berlin
Message-ID: <20100405194454.GA3808951@CIS.FU-Berlin.DE>
References: <20100329105748.GD14869@CIS.FU-Berlin.DE>
 <1UypQMCHLT57SnjSQIM66RTkLalsvavG8xXoQJv4rEQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:45:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NysEJ-00061U-E7
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab0DETo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:44:58 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:50964 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753416Ab0DETo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 15:44:57 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NysEC-0000Ih-DL>; Mon, 05 Apr 2010 21:44:56 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NysEB-0007EL-3p>; Mon, 05 Apr 2010 21:44:55 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NysEB-00GoR9-04>; Mon, 05 Apr 2010 21:44:55 +0200
Mail-Followup-To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1UypQMCHLT57SnjSQIM66RTkLalsvavG8xXoQJv4rEQ@cipher.nrlssc.navy.mil>
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144056>

* Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> [2010-04-05 11:45]:
> Could it be that you are using a third party iconv library?
> I've experienced this on another system and the problem was related
> to curl.  In that case, curl was linked against an external iconv and
> not the native library, so if I tried to build with curl support, I had
> to also build against the external iconv library.

This was exactly the problem in our case, too.  I'm sorry for the
incorrect patch.

Holger

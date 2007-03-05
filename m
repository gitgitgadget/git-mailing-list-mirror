From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 5/6] Fix some "comparison is always true/false" warnings.
Date: Mon, 5 Mar 2007 08:45:02 +0100
Message-ID: <20070305074502.GA31507@diana.vm.bytemark.co.uk>
References: <45E9BE69.4070508@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:45:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO7sk-0000Bu-FV
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 08:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbXCEHpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 02:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbXCEHpN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 02:45:13 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3981 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbXCEHpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 02:45:13 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HO7sU-0008GX-00; Mon, 05 Mar 2007 07:45:02 +0000
Content-Disposition: inline
In-Reply-To: <45E9BE69.4070508@ramsay1.demon.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41407>

On 2007-03-03 18:28:57 +0000, Ramsay Jones wrote:

> +typedef unsigned int ucs_char_t;  /* assuming 32bit int */

Umm ... wouldn't an uint32_t be a better fit here?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

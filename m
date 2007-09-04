From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Functions for updating refs.
Date: Tue, 4 Sep 2007 17:29:01 +0200
Message-ID: <20070904152901.GA31299@diana.vm.bytemark.co.uk>
References: <46DD6020.4050401@gmail.com> <Pine.LNX.4.64.0709041444070.28586@racer.site> <46DD6B93.10005@eudaptics.com> <Pine.LNX.4.64.0709041557590.28586@racer.site> <46DD7506.3090503@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISaLU-0003o2-Tb
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbXIDP3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 11:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbXIDP3g
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:29:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3483 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbXIDP3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:29:35 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1ISaKr-0008Ag-00; Tue, 04 Sep 2007 16:29:01 +0100
Content-Disposition: inline
In-Reply-To: <46DD7506.3090503@eudaptics.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57598>

On 2007-09-04 17:08:54 +0200, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
>
> > Well, my idea was to let _error() print the message, and just die()=
=2E
>
> How do you avoid that die() prints an error, too?

Make a generic function that takes a function pointer argument, then
call it with die or error as appropriate.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

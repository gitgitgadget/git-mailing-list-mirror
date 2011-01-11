From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 20:32:42 +0100
Message-ID: <201101112032.42880.chriscool@tuxfamily.org>
References: <20110106213338.GA15325@burratino> <20110111175031.GA2085@sigill.intra.peff.net> <20110111175621.GC15133@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:33:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcjxh-0007uA-W6
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558Ab1AKTcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:32:53 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45074 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932191Ab1AKTcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:32:52 -0500
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 70D09A6196;
	Tue, 11 Jan 2011 20:32:44 +0100 (CET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <20110111175621.GC15133@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164980>

Hi,

On Tuesday 11 January 2011 18:56:21 Jonathan Nieder wrote:
> 
> A potential usability enhancement might be to allow additional
> replacement hierarchies to be requested on a per command basis, like
> 
> 	GIT_REPLACE_REFS=refs/remotes/origin/views/2009 gitk --all
> 
> along the lines of GIT_NOTES_REF.

Yes, it should not be much work to implement GIT_REPLACE_REFS like the above, 
but I think it should accept a list of ref directories, for example:

GIT_REPLACE _REFS=".:bisect:refs/remotes/origin/views/2009"

Best regards,
Christian.

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/2] fast-import: introduce "feature notes" command
Date: Tue, 1 Feb 2011 22:58:26 -0600
Message-ID: <20110202045826.GC15285@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 02 05:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkUnq-0006Ft-1d
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 05:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab1BBE6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 23:58:32 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51422 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab1BBE6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 23:58:31 -0500
Received: by gxk9 with SMTP id 9so2818651gxk.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 20:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=TK1YI/mINdc3DMDFCLAxRlYACs6yqTgWoJiBLlxgJUE=;
        b=bhI13tAc1GWAgTboRBBZ6Jrn3lG7tChwWAQLbLrA/e48cy41p03ZqV2HV2LOOyXDcp
         gRgAT9CfnTxo4zQztiQRfLgHOA1qwSsDgv6r80pl2VTb9fheTaPOPKpBkgkOT2CCHbqm
         M/mpCJ10cVq5SBrwtFVDfLqW0/mlwgY8VXzFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=h9JUvEs8po0ESrjY/t8OQTuIESbTIrojb8NMnjBxO9GyVF2bKfcx2kO7JrPWZ/k96a
         vjasxj83Yz9MLCaN4qGajuucF2Vg+JiUBtinaj49/nupoQZHpFD0qzQzLLpsMh3aztJp
         I+ThffXSTtloyDv+cvwxmcQo6m89qBWP6uxZY=
Received: by 10.150.95.15 with SMTP id s15mr1319963ybb.50.1296622710839;
        Tue, 01 Feb 2011 20:58:30 -0800 (PST)
Received: from elie (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id v8sm14695253yba.2.2011.02.01.20.58.28
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 20:58:29 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165895>

Hi,

As promised, here is a "feature" command for streams to use to require
support for the notemodify (N) command.

Patch 1 explains how to delete notes.  On first reading, I had thought
that feature was missing.

Patch 2 is the title feature.  The relevant message explains why
this is an rfc.

Thoughts welcome, as always.

Jonathan Nieder (2):
  Documentation/fast-import: explain how to delete a note
  fast-import: introduce "feature notes" command

 Documentation/git-fast-import.txt |   18 ++++++++++--------
 fast-import.c                     |    6 ++++--
 t/t9301-fast-import-notes.sh      |    1 +
 3 files changed, 15 insertions(+), 10 deletions(-)

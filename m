From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: gitweb: broken links with pathinfo
Date: Sun, 27 Nov 2011 05:02:45 +0100
Message-ID: <CAKD0UuxGWLb5Dgp71p_fn1k1hJFDdzPOL0rAvhJHf6pjyHAxSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 05:03:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUVxb-0001yo-Vr
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 05:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab1K0EDM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Nov 2011 23:03:12 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58322 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab1K0EDJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2011 23:03:09 -0500
Received: by wwp14 with SMTP id 14so6484654wwp.1
        for <git@vger.kernel.org>; Sat, 26 Nov 2011 20:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=6NcCmAL8+prEXn+spTPUWpQWn1wPyD4K/tXdveRONRQ=;
        b=bEbLrBftmjTX/MFqnXgeI8iGEVTLKJ4K5yGncCPvLwAPCQUn1dvKt3Uh+4zeOotVt8
         2a2Adelf+i1EZdZDDXwi9Uu78dTHhSr0OhLorm0tCsgvqXdGhQVYsDfO8C0bMmqoSDOa
         ZsRN40M7WrQn2X2Dg7n3Eumpvf5BI851zmP/A=
Received: by 10.216.132.215 with SMTP id o65mr854216wei.17.1322366587081; Sat,
 26 Nov 2011 20:03:07 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Sat, 26 Nov 2011 20:02:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185964>

Hi,

if pathinfo (gitweb.perl 208a1cc3d3) is enabled, some pages lead to
404 errors.  For example, on
https://git.blackdown.de/contactalbum.git/blobdiff/c7fdc45614bd12758185=
2ce429c4483b1d21c0d4..82f7c8babf6095224bf5d8ab04f6eea4b1a555ee:/Classes=
/WindowController.h

a/Classes/WindowController.h ->
https://git.blackdown.de/contactalbum.git/blob/3c27189e8adc690f421334a9=
cad7ad719c066eb4:/Classes/WindowController.h
b/Classes/WindowController.h ->
https://git.blackdown.de/contactalbum.git/blob/f285b2728d2c7782806f0b7f=
6d696b226a88f03c:/Classes/WindowController.h

Both links give '404 - Cannot find file'


With pathinfo disabled, I get the following working URLs intead:

a/Classes/WindowController.h ->
https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblob;f=3DClasses/Win=
dowController.h;h=3D3c27189e8adc690f421334a9cad7ad719c066eb4;hb=3D3c271=
89e8adc690f421334a9cad7ad719c066eb4
b/Classes/WindowController.h ->
https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblob;f=3DClasses/Win=
dowController.h;h=3Df285b2728d2c7782806f0b7f6d696b226a88f03c;hb=3Df285b=
2728d2c7782806f0b7f6d696b226a88f03c


J=C3=BCrgen

--=20
http://blog.blackdown.de/
http://www.flickr.com/photos/jkreileder/

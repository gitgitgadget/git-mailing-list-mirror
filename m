From: Wink Saville <wink@saville.com>
Subject: Git gui error RenderBadPicture
Date: Sun, 5 Jul 2009 16:40:46 -0700
Message-ID: <d4cf37a60907051640k215595a1n95b720201243fc89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 01:42:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNbLO-0007Y6-Op
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 01:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883AbZGEXko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2009 19:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755755AbZGEXkn
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 19:40:43 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:44961 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbZGEXkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 19:40:43 -0400
Received: by yxe26 with SMTP id 26so5064255yxe.33
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 16:40:46 -0700 (PDT)
Received: by 10.100.251.7 with SMTP id y7mr7220275anh.178.1246837246529; Sun, 
	05 Jul 2009 16:40:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122766>

I recently upgraded to ubuntu 9.04 and now I'm getting the
following error when when closing git gui using the "close button",
when exiting via Ctrl-Q this error does not occur:

wink@pacific:~/foss/protobuf-2.1.0$ git gui
X Error of failed request: =A0RenderBadPicture (invalid Picture paramet=
er)
=A0=A0Major opcode of failed request: =A0152 (RENDER)
=A0=A0Minor opcode of failed request: =A07 (RenderFreePicture)
=A0=A0Picture id in failed request: 0x3a000e2
=A0=A0Serial number of failed request: =A01845
=A0=A0Current serial number in output stream: =A01860

There appears to be no ill effects but it is disconcerting and I'll try
to get in the habit of quiting via Ctrl-Q but thought someone might
like to know. I've built git from sources and the version is:

wink@pacific:~/foss/protobuf-2.1.0$ git --version
git version 1.6.3.GIT

-- Wink

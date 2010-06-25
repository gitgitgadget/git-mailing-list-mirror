From: Laszlo Papp <djszapi@archlinux.us>
Subject: FR: Clone just the desired subdirectory
Date: Fri, 25 Jun 2010 16:24:52 +0200
Message-ID: <AANLkTilyvCWyWzqPGxtg9tkRM5SjXxbt50P5zImlxCHD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 25 16:25:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS9q5-0004Kv-3J
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 16:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab0FYOY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 10:24:59 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:65466 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0FYOY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 10:24:59 -0400
Received: by wwi17 with SMTP id 17so1102664wwi.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 07:24:52 -0700 (PDT)
Received: by 10.227.152.76 with SMTP id f12mr664348wbw.54.1277475892405; Fri, 
	25 Jun 2010 07:24:52 -0700 (PDT)
Received: by 10.216.163.6 with HTTP; Fri, 25 Jun 2010 07:24:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149685>

Hi,

Is there a way to clone
git://git.openembedded.org/openembedded/recipes/qt4, not the whole
repository ?

I have just tried this command, but it doesn't service the capable habit:
git clone --depth 1 git://git.openembedded.org/openembedded/

I have seen on a good feature in case gitorious where you can select a
folder to download in a compressed format (*.tar.gz for instance). Can
it be implemented in case git 'backend' ?

My friend asked it from me, but I couldn't advise anything to him, but
this request does make sense by me. So he would like to download a
part of a git repository and he is not interested in the index and the
history, so it would be nice to have something like git archive
--remote or similar command which can do this operation.

Best Regards,
Laszlo Papp

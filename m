From: Eugene Sajine <euguess@gmail.com>
Subject: ident hash usage question
Date: Tue, 20 Oct 2009 13:24:52 -0400
Message-ID: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 19:25:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ISD-0002Qn-BK
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 19:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbZJTRYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 13:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbZJTRYt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 13:24:49 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:61605 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbZJTRYs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 13:24:48 -0400
Received: by gxk4 with SMTP id 4so4864687gxk.8
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=LHurAyVu4zYh9MWxrvWaOK8MCvtY77xWlaapP1+FZrY=;
        b=w6G7ykFbqrS95RmYdJWSeF1k00ILm796DloemjmxUxRFeuHSnjWYGzCgt52iKy+WKp
         Ku3+u2Yc15wGl8EFzKQso6/QTfg6+8fQASt0rE8mr011/dzQutC8SULSza+B3VqL45XN
         /719113Ueo8RC71+M2+C0a9QSrYZTwzKHygHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=os8WvPSAGo10PpB6zhhU3ClwreN7CZJOu4UtTNHU4uJXIYudiSshMuII2xjnA8H1yq
         FH55lmUK0C+uXy853PUcfTAPIEBykmy7L5mEa0hxiYVpk8OJ8/DRPNn70MkU/j0KreHi
         crjEc0ZlsNYkNcXY0kmuQd+tNeX5aUlPcmRGc=
Received: by 10.91.45.22 with SMTP id x22mr6869245agj.120.1256059492617; Tue, 
	20 Oct 2009 10:24:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130818>

Hi,

Please correct me if I=E2=80=99m missing something, but:

I was able to get the $Id$ keyword to show the SHA-1 hash of the file
content, which is done using ident in gitattributes. Now I=E2=80=99m tr=
ying to
find a way to get more info about the file using only this hash.

Could you , please, advise if there is a way to get file name and path
inside the repo by having only this Blob hash?

Thank you,
Eugene

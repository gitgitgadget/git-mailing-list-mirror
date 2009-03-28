From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [EGIT] How to deal with important modifications
Date: Sat, 28 Mar 2009 18:32:08 +0100
Message-ID: <1238261528.6971.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 28 18:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LncQ9-0001B7-RA
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 18:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbZC1RcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbZC1RcM
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 13:32:12 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:57559 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbZC1RcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 13:32:11 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so1382838bwz.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=5XJ7XJrrhkuyC7GcXRah07LIemeKOkq5dGSEpWh/daw=;
        b=Fug6rwo1thOB5thLSc/D17bNyutS0g0SX0w2rVc0fH8thPI55Xl1di8kgOD4hVG7V/
         W+j7wxWK/tc9+PWY4AKTlU5ivd7jeXkwHsxk7FMDBc0K0BEYqJH5vn5SACmO3kVs6mKr
         hNITe8RgsbH87Ezgn8OhblvzSgRAFw/VqXf6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=N0jT5YaI8X94LRN3doUc+tk3J10MnVQW5vKoZ72J5knANOJ46j+88iXRmPhqSJeTZ1
         MpRmbmB+RN8lWN1cIG+UGoBRrGDBN+mM4Ml1WA0q+ATYRsR1IDc8LpTOGxuVvn5190YR
         EAtXmrUImoaGxZi5EMYMuhlR7gcMshoGc1nx8=
Received: by 10.103.240.5 with SMTP id s5mr904336mur.133.1238261529713;
        Sat, 28 Mar 2009 10:32:09 -0700 (PDT)
Received: from ?85.178.115.172? (e178115172.adsl.alicedsl.de [85.178.115.172])
        by mx.google.com with ESMTPS id s10sm5480166muh.22.2009.03.28.10.32.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 10:32:09 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114971>

Hi,

I am working on the synchronization view. It is not 100% functional yet.
The view is not updated when a local file is modified for example.
As the modifications are getting important, I was wondering how to deal
with it. Should I continue my work an send all the patches when
finished?

To have an overview of the modifications:
http://github.com/yanns/egit/commit/18c4a928d53345802a8c9641dcb2d457ebbe2cbc
http://github.com/yanns/egit/commit/9fab398fa1b7b6efa9532b3c09e5bcfcc8bb9419

Or should I begin to send patches, but by not activating the function
yet?
(It could be a way to have other people to help contributing.)

Yann

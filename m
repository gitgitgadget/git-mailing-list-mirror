X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Diffs from CVS keyword expansion
Date: Thu, 30 Nov 2006 22:56:57 -0500
Message-ID: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 03:57:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K80SMvLpynkCBKHCR9eXfAD7sbp3njc9iPhTOMnT0/LC+VbLhlSdMzkU5F5uvzJGBSowFt5sO3W5UbFfeDCc4Mx8V2wNu6uN4Y3J7Uq03+xQ3eD+HRq5w1phRw0AUxJ5k5EZBl7jeTagGAYzRw/e7dRNgNKKHw5sGqn7L/sYzwQ=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32848>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpzWN-0005kj-Br for gcvg-git@gmane.org; Fri, 01 Dec
 2006 04:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758853AbWLAD5E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 22:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758546AbWLAD5E
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 22:57:04 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:36717 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1758852AbWLAD5D
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 22:57:03 -0500
Received: by py-out-1112.google.com with SMTP id a29so1754772pyi for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 19:56:57 -0800 (PST)
Received: by 10.35.110.13 with SMTP id n13mr527968pym.1164945417482; Thu, 30
 Nov 2006 19:56:57 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Thu, 30 Nov 2006 19:56:57 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Anyone have a nice script for suppressing diffs caused by CVS keyword
expansion when someone checked the kernel sources into CVS?

I have 200,000 lines of various forms of this mixed in with real changes

It is unclear who checked it into CVS, Microcross or Arch Linux. If it
is Arch Linux finding the source for their 2.6.11.4-1 release would
help a lot. I looked on their web site and couldn't locate it.

I'm starting understand why the support for MX21 on a CSB535FS has
never been added to the mainline.

diff --git a/drivers/char/ftape/lowlevel/ftape-ctl.c
b/drivers/char/ftape/lowlevel/ftape-ctl.c
index 32e0439..ff10633 100644
--- a/drivers/char/ftape/lowlevel/ftape-ctl.c
+++ b/drivers/char/ftape/lowlevel/ftape-ctl.c
@@ -17,9 +17,9 @@
  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

  *
- * $Source: /homes/cvs/ftape-stacked/ftape/lowlevel/ftape-ctl.c,v $
- * $Revision: 1.4 $
- * $Date: 1997/11/11 14:37:44 $
+ * $Source: /home/arch-linux/{cvs}/linux--dev--2.6/drivers/char/ftape/lowlevel/ftape-ctl.c,v
$
+ * $Revision: 1.1.1.1 $
+ * $Date: 2005/03/24 06:16:39 $
  *
  *      This file contains the non-read/write ftape functions for the
  *      QIC-40/80/3010/3020 floppy-tape driver "ftape" for Linux.
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c
b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 63c8168..54d9a10 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -29,7 +29,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ipoib_main.c 1377 2004-12-23 19:57:12Z roland $
+ * $Id: ipoib_main.c,v 1.1.1.1 2005/03/24 06:16:41 arch-linux Exp $
  */

 #include "ipoib.h"

-- 
Jon Smirl

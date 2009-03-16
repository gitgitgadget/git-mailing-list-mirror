From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] tidspbridge: remove revision history
Date: Mon, 16 Mar 2009 23:57:41 +0200
Message-ID: <1237240661-4378-1-git-send-email-felipe.contreras@gmail.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>,
	Hiroshi DOYU <hiroshi.doyu@nokia.com>,
	Ameya Palande <ameya.palande@nokia.com>,
	Fernando Guzman Lugo <x0095840@ti.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 22:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjKqc-0003rY-LM
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 22:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759776AbZCPV6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759430AbZCPV6R
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 17:58:17 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:47069 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902AbZCPV6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 17:58:13 -0400
Received: by fxm24 with SMTP id 24so3685582fxm.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7S5REaf9FQHTnDYKfAPZhR48hku0I1Ywi9IriE+UJTQ=;
        b=VUJ/1Okka2IOxDHwaQ26AYZMih0vqEOV9Gc2GsA+CRz8MFl1z00zG0xKlsSPJV534O
         vGwmD8oRtMxAs4/RQthTe5BVX4COlfoPbbWW16LAnTAv8L2pgqDMMJCVxKXjd/AuAsar
         fwhsrjoSpY03pa9heEQZ6d2XoJEm8AkBhrfhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nitw65d1m3QfapF/ySC2s/qb1IHBwoy7W+98b+bcghRH0GD94re1E5FBKUF1B6nMfu
         45MOuYyGNBU/DKrVEGlH6F+k7Km+SgmqrERoE7auDofKBc9HU6vO6BSCLN1tL3rM3Hl8
         6Y1Jo40mYbawCF5DNu2L30C0LN3xTnRuM8d9I=
Received: by 10.223.105.16 with SMTP id r16mr1845102fao.24.1237240688909;
        Mon, 16 Mar 2009 14:58:08 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id y15sm8997521fkd.32.2009.03.16.14.58.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Mar 2009 14:58:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.313.g33352
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113390>

No need for that with git.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/gen/_gt_para.c       |    8 ----
 drivers/dsp/bridge/gen/gb.c             |    8 ----
 drivers/dsp/bridge/gen/gs.c             |    7 ---
 drivers/dsp/bridge/gen/gt.c             |    7 ---
 drivers/dsp/bridge/gen/uuidutil.c       |   10 ----
 drivers/dsp/bridge/hw/GlobalTypes.h     |    3 -
 drivers/dsp/bridge/hw/hw_defs.h         |    4 --
 drivers/dsp/bridge/hw/hw_dspssC64P.c    |    4 --
 drivers/dsp/bridge/hw/hw_dspssC64P.h    |    5 --
 drivers/dsp/bridge/hw/hw_mbox.c         |    3 -
 drivers/dsp/bridge/hw/hw_mbox.h         |    3 -
 drivers/dsp/bridge/hw/hw_mmu.c          |    8 ----
 drivers/dsp/bridge/hw/hw_mmu.h          |    6 ---
 drivers/dsp/bridge/hw/hw_prcm.c         |    3 -
 drivers/dsp/bridge/hw/hw_prcm.h         |    3 -
 drivers/dsp/bridge/pmgr/chnl.c          |   23 ----------
 drivers/dsp/bridge/pmgr/chnlobj.h       |    6 ---
 drivers/dsp/bridge/pmgr/cmm.c           |   25 -----------
 drivers/dsp/bridge/pmgr/cod.c           |   30 -------------
 drivers/dsp/bridge/pmgr/dbl.c           |   12 -----
 drivers/dsp/bridge/pmgr/dbll.c          |   15 -------
 drivers/dsp/bridge/pmgr/dev.c           |   49 ----------------------
 drivers/dsp/bridge/pmgr/dmm.c           |    9 ----
 drivers/dsp/bridge/pmgr/io.c            |    5 --
 drivers/dsp/bridge/pmgr/ioobj.h         |    4 --
 drivers/dsp/bridge/pmgr/msg.c           |    7 ---
 drivers/dsp/bridge/pmgr/msgobj.h        |    4 --
 drivers/dsp/bridge/pmgr/wcd.c           |   62 ---------------------------
 drivers/dsp/bridge/rmgr/dbdcd.c         |   32 --------------
 drivers/dsp/bridge/rmgr/disp.c          |   11 -----
 drivers/dsp/bridge/rmgr/drv.c           |   53 -----------------------
 drivers/dsp/bridge/rmgr/drv_interface.c |   15 -------
 drivers/dsp/bridge/rmgr/drv_interface.h |    6 ---
 drivers/dsp/bridge/rmgr/dspdrv.c        |   69 -------------------------------
 drivers/dsp/bridge/rmgr/mgr.c           |   16 -------
 drivers/dsp/bridge/rmgr/nldr.c          |   15 -------
 drivers/dsp/bridge/rmgr/node.c          |   46 --------------------
 drivers/dsp/bridge/rmgr/proc.c          |   56 -------------------------
 drivers/dsp/bridge/rmgr/pwr.c           |    6 ---
 drivers/dsp/bridge/rmgr/rmm.c           |    9 ----
 drivers/dsp/bridge/rmgr/strm.c          |   18 --------
 drivers/dsp/bridge/services/cfg.c       |   38 -----------------
 drivers/dsp/bridge/services/clk.c       |    4 --
 drivers/dsp/bridge/services/csl.c       |   21 ---------
 drivers/dsp/bridge/services/dbg.c       |   12 -----
 drivers/dsp/bridge/services/dpc.c       |   14 ------
 drivers/dsp/bridge/services/kfile.c     |   10 ----
 drivers/dsp/bridge/services/list.c      |   12 -----
 drivers/dsp/bridge/services/mem.c       |   18 --------
 drivers/dsp/bridge/services/ntfy.c      |    9 ----
 drivers/dsp/bridge/services/reg.c       |    3 -
 drivers/dsp/bridge/services/regsup.c    |    6 ---
 drivers/dsp/bridge/services/regsup.h    |    2 -
 drivers/dsp/bridge/services/services.c  |    6 ---
 drivers/dsp/bridge/services/sync.c      |   12 -----
 drivers/dsp/bridge/wmd/_cmm.h           |    3 -
 drivers/dsp/bridge/wmd/_deh.h           |    3 -
 drivers/dsp/bridge/wmd/_msg_sm.h        |    4 --
 drivers/dsp/bridge/wmd/_tiomap.h        |   22 ----------
 drivers/dsp/bridge/wmd/_tiomap_mmu.h    |    6 ---
 drivers/dsp/bridge/wmd/_tiomap_pwr.h    |    3 -
 drivers/dsp/bridge/wmd/_tiomap_util.h   |    3 -
 drivers/dsp/bridge/wmd/chnl_sm.c        |   53 -----------------------
 drivers/dsp/bridge/wmd/io_sm.c          |   64 ----------------------------
 drivers/dsp/bridge/wmd/mmu_fault.c      |   10 ----
 drivers/dsp/bridge/wmd/mmu_fault.h      |    4 --
 drivers/dsp/bridge/wmd/msg_sm.c         |   10 ----
 drivers/dsp/bridge/wmd/tiomap3430.c     |    3 -
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    8 ----
 drivers/dsp/bridge/wmd/tiomap_io.c      |    7 ---
 drivers/dsp/bridge/wmd/tiomap_io.h      |    3 -
 drivers/dsp/bridge/wmd/tiomap_sm.c      |   15 -------
 drivers/dsp/bridge/wmd/ue_deh.c         |    9 ----
 73 files changed, 0 insertions(+), 1082 deletions(-)

diff --git a/drivers/dsp/bridge/gen/_gt_para.c b/drivers/dsp/bridge/gen/_gt_para.c
index 181fe41..b363590 100644
--- a/drivers/dsp/bridge/gen/_gt_para.c
+++ b/drivers/dsp/bridge/gen/_gt_para.c
@@ -24,14 +24,6 @@
  *      etc. into a fully bound image.  Thus, GT_assert() can be retained in
  *      a program for which GT_?trace() has been compiled out.
  *
- *! Revision History:
- *! ================
- *! 24-Feb-2003 vp: Code Review Updates.
- *! 18-Oct-2002 sb: Ported to Linux platform.
- *! 03-Jul-2001 rr: Removed kfuncs.h because of build errors.
- *! 07-Dec-1999 ag: Fxn error now causes a WinCE DebugBreak;
- *! 30-Aug-1999 ag: Now uses GP_printf for printf and error.
- *!
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/gen/gb.c b/drivers/dsp/bridge/gen/gb.c
index 1d21e97..b32902d 100644
--- a/drivers/dsp/bridge/gen/gb.c
+++ b/drivers/dsp/bridge/gen/gb.c
@@ -19,14 +19,6 @@
  *  ======== gb.c ========
  *  Description: Generic bitmap operations.
  *
- *! Revision History
- *! ================
- *! 24-Feb-2003 vp  Code review updates.
- *! 17-Dec-2002 map Fixed GB_minset(), GB_empty(), and GB_full(),
- *!                 to ensure only 'len' bits are considered in the map
- *! 18-Oct-2002 sb  Ported to Linux platform.
- *! 06-Dec-2001 jeh Fixed bug in GB_minclear().
- *!
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/gen/gs.c b/drivers/dsp/bridge/gen/gs.c
index ef5f923..3f1ef7a 100644
--- a/drivers/dsp/bridge/gen/gs.c
+++ b/drivers/dsp/bridge/gen/gs.c
@@ -20,13 +20,6 @@
  *  Description:
  *      General storage memory allocator services.
  *
- *! Revision History
- *! ================
- *! 29-Sep-1999 ag:  Un-commented MEM_Init in GS_init().
- *! 14-May-1997 mg:  Modified to use new GS API for GS_free() and GS_frees().
- *! 06-Nov-1996 gp:  Re-commented MEM_Init in GS_init(). GS needs GS_Exit().
- *! 21-Oct-1996 db:  Un-commented MEM_Init in GS_init().
- *! 21-May-1996 mg:  Created from original stdlib implementation.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/gen/gt.c b/drivers/dsp/bridge/gen/gt.c
index 452d6e6..f8a6ae6 100644
--- a/drivers/dsp/bridge/gen/gt.c
+++ b/drivers/dsp/bridge/gen/gt.c
@@ -19,13 +19,6 @@
  * ======== gt.c ========
  * Description: This module implements the trace mechanism for bridge.
  *
- *! Revision History
- *! ================
- *! 16-May-1997 dr	Changed GT_Config member names to conform to coding
- *!			standards.
- *! 23-Apr-1997 ge	Check for GT->TIDFXN for NULL before calling it.
- *! 03-Jan-1997	ge	Changed GT_Config structure member names to eliminate
- *!			preprocessor confusion with other macros.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/gen/uuidutil.c b/drivers/dsp/bridge/gen/uuidutil.c
index a45f448..b1bdc53 100644
--- a/drivers/dsp/bridge/gen/uuidutil.c
+++ b/drivers/dsp/bridge/gen/uuidutil.c
@@ -20,16 +20,6 @@
  *  Description:
  *  This file contains the implementation of UUID helper functions.
  *
- *! Revision History
- *! ================
- *! 23-Feb-2003 vp: Code review updates.
- *! 18-Oct-2003 vp: Ported to Linux platform.
- *! 31-Aug-2000 rr: UUID_UuidFromString bug fixed.
- *! 29-Aug-2000 rr: Modified UUID_UuidFromString.
- *! 09-Nov-2000 kc: Modified UUID_UuidFromString to simplify implementation.
- *! 30-Oct-2000 kc: Modified UUID utility module function prefix.
- *! 10-Aug-2000 kc: Created.
- *!
  */
 
 /*  ----------------------------------- Host OS  */
diff --git a/drivers/dsp/bridge/hw/GlobalTypes.h b/drivers/dsp/bridge/hw/GlobalTypes.h
index 9004a37..c5e2085 100644
--- a/drivers/dsp/bridge/hw/GlobalTypes.h
+++ b/drivers/dsp/bridge/hw/GlobalTypes.h
@@ -20,9 +20,6 @@
  *  Description:
  *      Global HW definitions
  *
- *! Revision History:
- *! ================
- *! 16 Feb 2003 sb: Initial version
  */
 #ifndef __GLOBALTYPES_H
 #define __GLOBALTYPES_H
diff --git a/drivers/dsp/bridge/hw/hw_defs.h b/drivers/dsp/bridge/hw/hw_defs.h
index a973f5c..cfdc4f9 100644
--- a/drivers/dsp/bridge/hw/hw_defs.h
+++ b/drivers/dsp/bridge/hw/hw_defs.h
@@ -20,10 +20,6 @@
  *  Description:
  *      Global HW definitions
  *
- *! Revision History:
- *! ================
- *! 19 Apr 2004 sb: Added generic page size, endianness and element size defns
- *! 16 Feb 2003 sb: Initial version
  */
 #ifndef __HW_DEFS_H
 #define __HW_DEFS_H
diff --git a/drivers/dsp/bridge/hw/hw_dspssC64P.c b/drivers/dsp/bridge/hw/hw_dspssC64P.c
index a4b7c30..0bee47b 100644
--- a/drivers/dsp/bridge/hw/hw_dspssC64P.c
+++ b/drivers/dsp/bridge/hw/hw_dspssC64P.c
@@ -19,10 +19,6 @@
  *  Description:
  *      API definitions to configure DSP Subsystem modules like IPI
  *
- *! Revision History:
- *! ================
- *! 19 Apr 2004 sb: Implemented HW_DSPSS_IPIEndianismSet
- *! 16 Feb 2003 sb: Initial version
  */
 
 /* PROJECT SPECIFIC INCLUDE FILES */
diff --git a/drivers/dsp/bridge/hw/hw_dspssC64P.h b/drivers/dsp/bridge/hw/hw_dspssC64P.h
index 493effd..1694e2a 100644
--- a/drivers/dsp/bridge/hw/hw_dspssC64P.h
+++ b/drivers/dsp/bridge/hw/hw_dspssC64P.h
@@ -20,11 +20,6 @@
  *  Description:
  *      DSP Subsystem API declarations
  *
- *! Revision History:
- *! ================
- *! 19-Apr-2004 sb: Removed redundant argument from HW_DSPSS_IPIEndianismSet
- *!		    Moved endianness and element size to generic hw_defs.h
- *! 16 Feb 2003 sb: Initial version
  */
 
 #ifndef __HW_DSPSS_H
diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index 2c14ade..49bdeb4 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -20,9 +20,6 @@
  *  Description:
  *      Mailbox messaging & configuration API definitions
  *
- *! Revision History:
- *! ================
- *! 16 Feb 2003 sb: Initial version
  */
 
 #include <GlobalTypes.h>
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index 225fb40..00e0f5e 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -19,9 +19,6 @@
  *  Description:
  *      HW Mailbox API and types definitions
  *
- *! Revision History:
- *! ================
- *! 16 Feb 2003 sb: Initial version
  */
 #ifndef __MBOX_H
 #define __MBOX_H
diff --git a/drivers/dsp/bridge/hw/hw_mmu.c b/drivers/dsp/bridge/hw/hw_mmu.c
index da7e092..e143187 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.c
+++ b/drivers/dsp/bridge/hw/hw_mmu.c
@@ -19,14 +19,6 @@
  *  Description:
  *      API definitions to setup MMU TLB and PTE
  *
- *! Revision History:
- *! ================
- *! 19-Apr-2004 sb  TLBAdd and TLBFlush input the page size in bytes instead
-		    of an enum. TLBAdd inputs mapping attributes struct instead
-		    of individual arguments.
-		    Removed MMU.h and other cosmetic updates.
- *! 08-Mar-2004 sb  Added the Page Table Management APIs
- *! 16 Feb 2003 sb: Initial version
  */
 
 #include <GlobalTypes.h>
diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/hw_mmu.h
index 924f32b..07c7235 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.h
+++ b/drivers/dsp/bridge/hw/hw_mmu.h
@@ -20,12 +20,6 @@
  *  Description:
  *      MMU types and API declarations
  *
- *! Revision History:
- *! ================
- *! 19-Apr-2004 sb  Moved & renamed endianness, page size, element size
-		    TLBAdd takes in MMUMapAttrs instead of separate arguments
- *! 08-Mar-2004 sb  Added the Page Table management APIs
- *! 16 Feb 2003 sb: Initial version
  */
 #ifndef __HW_MMU_H
 #define __HW_MMU_H
diff --git a/drivers/dsp/bridge/hw/hw_prcm.c b/drivers/dsp/bridge/hw/hw_prcm.c
index 61ff08f..b371c62 100644
--- a/drivers/dsp/bridge/hw/hw_prcm.c
+++ b/drivers/dsp/bridge/hw/hw_prcm.c
@@ -19,9 +19,6 @@
  *  Description:
  *      API definitions to configure PRCM (Power, Reset & Clocks Manager)
  *
- *! Revision History:
- *! ================
- *! 16 Feb 2003 sb: Initial version
  */
 
 #include <GlobalTypes.h>
diff --git a/drivers/dsp/bridge/hw/hw_prcm.h b/drivers/dsp/bridge/hw/hw_prcm.h
index 928486c..c482142 100644
--- a/drivers/dsp/bridge/hw/hw_prcm.h
+++ b/drivers/dsp/bridge/hw/hw_prcm.h
@@ -19,9 +19,6 @@
  *  Description:
  *      PRCM types and API declarations
  *
- *! Revision History:
- *! ================
- *! 16 Feb 2003 sb: Initial version
  */
 
 #ifndef __HW_PRCM_H
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 6b5a0d9..1226e79 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -37,29 +37,6 @@
  *      except for the CHNL_Get() accessor functions which call
  *      WMD_CHNL_GetInfo().
  *
- *! Revision History:
- *! ================
- *! 24-Feb-2003 swa PMGR Code review comments incorporated.
- *! 07-Jan-2002 ag  CHNL_CloseOrphans() now closes supported # of channels.
- *! 17-Nov-2000 jeh Removed IRQ, shared memory stuff from CHNL_Create.
- *! 28-Feb-2000 rr: New GT USage Implementation
- *! 03-Feb-2000 rr: GT and Module init/exit Changes.(Done up front from
- *!		    SERVICES)
- *! 21-Jan-2000 ag: Added code review comments.
- *! 13-Jan-2000 rr: CFG_Get/SetPrivateDword renamed to CFG_Get/SetDevObject.
- *! 08-Dec-1999 ag: CHNL_[Alloc|Free]Buffer bufs taken from client process heap.
- *! 02-Dec-1999 ag: Implemented CHNL_GetEventHandle().
- *! 17-Nov-1999 ag: CHNL_AllocBuffer() allocs extra word for process mapping.
- *! 28-Oct-1999 ag: WinCE port. Search for "WinCE" for changes(TBR).
- *! 07-Jan-1998 gp: CHNL_[Alloc|Free]Buffer now call MEM_UMB functions.
- *! 22-Oct-1997 gp: Removed requirement in CHNL_Open that hReserved1 != NULL.
- *! 30-Aug-1997 cr: Renamed cfg.h wbwcd.h b/c of WINNT file name collision.
- *! 10-Mar-1997 gp: Added GT trace.
- *! 14-Jan-1997 gp: Updated based on code review feedback.
- *! 03-Jan-1997 gp: Moved CHNL_AllocBuffer/CHNL_FreeBuffer code from udspsys.
- *! 14-Dec-1996 gp: Added uChnlId parameter to CHNL_Open().
- *! 09-Sep-1996 gp: Added CHNL_GetProcessHandle().
- *! 15-Jul-1996 gp: Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/pmgr/chnlobj.h b/drivers/dsp/bridge/pmgr/chnlobj.h
index da74c96..508789e 100644
--- a/drivers/dsp/bridge/pmgr/chnlobj.h
+++ b/drivers/dsp/bridge/pmgr/chnlobj.h
@@ -24,12 +24,6 @@
  *  Public Functions:
  *      None.
  *
- *! Revision History:
- *! ================
- *! 24-Feb-2003 swa 	PMGR Code review comments incorporated.
- *! 17-Nov-2000 jeh     Removed some fields from CHNL_MGR_ to match CHNL_MGR
- *!                     structure defined in _chnl_sm.h.
- *! 16-Jan-1997 gp:     Created from chnlpriv.h
  */
 
 #ifndef CHNLOBJ_
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 99a2432..59d559e 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -66,31 +66,6 @@
  *      Va: Virtual address.
  *      Pa: Physical or kernel system address.
  *
- *! Revision History:
- *! ================
- *! 24-Feb-2003 swa PMGR Code review comments incorporated.
- *! 16-Feb-2002 ag  Code review cleanup.
- *!                 PreOMAP address translation no longner supported.
- *! 30-Jan-2002 ag  Updates to CMM_XlatorTranslate() per TII, ANSI C++
- *!                 warnings.
- *! 27-Jan-2002 ag  Removed unused CMM_[Alloc][Free]Desc() & #ifdef USELOOKUP,
- *!                 & unused VALIDATECMM and VaPaConvert().
- *!                 Removed bFastXlate from CMM_XLATOR. Always fast lookup.
- *! 03-Jan-2002 ag  Clear SM in CMM_AllocBuf(). Renamed to CMM_CallocBuf().
- *! 13-Nov-2001 ag  Now delete pNodeFreeListHead and nodes in CMM_Destroy().
- *! 28-Aug-2001 ag  CMM_GetHandle() returns CMM Mgr hndle given HPROCESSOR.
- *!                 Removed unused CMM_[Un]RegisterDSPSMSeg() &
- *                  CMM_[Un}ReserveVirtSpace fxns. Some cleanup.
- *! 12-Aug-2001 ag  Exposed CMM_UnRegisterGPP[DSP]SMSeg.
- *! 13-Feb-2001 kc  DSP/BIOS Bridge name update.
- *! 21-Dec-2000 rr  GetFreeBlock checks for pAllocator.
- *! 09-Dec-2000 ag  Added GPPPA2DSPPA, DSPPA2GPPPA macros.
- *! 05-Dec-2000 ag  CMM_XlatorDelete() optionally frees SM bufs and descriptors.
- *! 30-Oct-2000 ag  Buf size bug fixed in CMM_AllocBuf() causing leak.
- *!                 Revamped XlatorTranslate() routine.
- *! 10-Oct-2000 ag  Added CMM_Xlator[xxx] functions.
- *! 02-Aug-2000 ag  Created.
- *!
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 8e354ac..b6ad465 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -23,36 +23,6 @@
  *  This module provides an interface for loading both static and
  *  dynamic code objects onto DSP systems.
  *
- *! Revision History
- *! ================
- *! 08-Apr-2003 map: Consolidated DBL to DBLL loader name
- *! 24-Feb-2003 swa: PMGR Code review comments incorporated.
- *! 18-Apr-2002 jeh: Added DBL function tables.
- *! 20-Nov-2001 jeh: Removed call to ZL_loadArgs function.
- *! 19-Oct-2001 jeh: Access DBL as a static library. Added COD_GetBaseLib,
- *!		  COD_GetLoader, removed COD_LoadSection, COD_UnloadSection.
- *! 07-Sep-2001 jeh: Added COD_LoadSection(), COD_UnloadSection().
- *! 07-Aug-2001 rr:  hMgr->baseLib is updated after zlopen in COD_LoadBase.
- *! 18-Apr-2001 jeh: Check for fLoaded flag before ZL_unload, to allow
- *!		  COD_OpenBase to be used.
- *! 11-Jan-2001 jeh: Added COD_OpenBase (not used yet, since there is an
- *!		  occasional crash).
- *! 02-Aug-2000 kc:  Added COD_ReadSection to COD module. Incorporates use
- *!		  of ZL_readSect (new function in ZL module).
- *! 28-Feb-2000 rr:  New GT Usage Implementation
- *! 08-Dec-1999 ag:  Removed x86 specific __asm int 3.
- *! 02-Oct-1999 ag:  Added #ifdef DEBUGINT3COD for debug.
- *! 20-Sep-1999 ag:  Removed call to GT_set().
- *! 04-Jun-1997 cr:  Added validation of argc/argv pair in COD_LoadBase, as it
- *!		     is a requirement to ZL_loadArgs.
- *! 31-May-1997 cr:  Changed COD_LoadBase argc value from u32 to int, added
- *!	       DSP_ENOTIMPL return value to COD_Create when attrs != NULL.
- *! 29-May-1997 cr:  Added debugging support.
- *! 24-Oct-1996 gp:  Added COD_GetSection().
- *! 18-Jun-1996 gp:  Updated GetSymValue() to check for lib; updated E_ codes.
- *! 12-Jun-1996 gp:  Imported CSL_ services for strcpyn(); Added ref counting.
- *! 20-May-1996 mg:  Adapted for new MEM and LDR modules.
- *! 08-May-1996 mg:  Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/pmgr/dbl.c b/drivers/dsp/bridge/pmgr/dbl.c
index 641b011..a23ea5a 100644
--- a/drivers/dsp/bridge/pmgr/dbl.c
+++ b/drivers/dsp/bridge/pmgr/dbl.c
@@ -21,18 +21,6 @@
  *  loading and unloading symbols/code/data on DSP.
  *  Also contains other support functions.
  *
- *! Revision History
- *! ================
- *! 24-Feb-2003 swa 	PMGR Code review comments incorporated.
- *! 24-May-2002 jeh     Free DCD sects in DBL_close().
- *! 19-Mar-2002 jeh     Changes made to match dynamic loader (dbll.c): Pass
- *!		     DBL_Library to DBL_getAddr() instead of DBL_Target,
- *!		     eliminate scope param, use DBL_Symbol. Pass attrs to
- *!		     DBL_load(), DBL_unload().
- *! 20-Nov-2001 jeh     Removed DBL_loadArgs().
- *! 07-Sep-2001 jeh     Added overlay support.
- *! 31-Jul-2001 jeh     Include windows.h.
- *! 06-Jun-2001 jeh     Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 82430a3..4ccd62e 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -17,21 +17,6 @@
 /*
  *  ======== dbll.c ========
  *
- *! Revision History
- *! ================
- *! 25-Apr-2030 map:    Fixed symbol redefinition bug + unload and return error
- *! 08-Apr-2003 map: 	Consolidated DBL with DBLL loader name
- *! 24-Mar-2003 map:    Updated findSymbol to support dllview update
- *! 23-Jan-2003 map:    Updated rmmAlloc to support memory granularity
- *! 21-Nov-2002 map:    Combine fopen and DLOAD_module_open to increase
- *!         performance on start.
- *! 04-Oct-2002 map:    Integrated new TIP dynamic loader w/ DOF api.
- *! 27-Sep-2002 map:    Changed handle passed to RemoteFree, instead of
- *!         RMM_free;  added GT_trace to rmmDealloc
- *! 20-Sep-2002 map:    Updated from Code Review
- *! 08-Aug-2002 jeh:    Updated to support overlays.
- *! 25-Jun-2002 jeh:    Pass RMM_Addr object to alloc function in rmmAlloc().
- *! 20-Mar-2002 jeh:    Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 1c2f7d5..35d4d4f 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -61,55 +61,6 @@
  *      RemoveDevObject
  *      StoreInterfaceFxns
  *
- *! Revision History:
- *! ================
- *! 03-Jan-2005 hn  Support for IVA DEH
- *! 08-Mar-2004 sb  Added the Dynamic Memory Mapping feature
- *! 09-Feb-2004 vp	Updated to support IVA.
- *! 24-Feb-2003 swa PMGR Code review comments incorporated.
- *! 29-Nov-2001 jeh Check for DSP_ENOTIMPL status of DEH create function.
- *! 05-Nov-2001 kc  Added support for DEH module.
- *! 05-Aug-2001 ag  Shared memory registration moved to WMD_IO_OnLoaded().
- *! 11-Jul-2001 jeh Moved MGR_Create() from DSP_Init() to DEV_StartDevice().
- *! 11-Apr-2001 rr: Removed CMM_RegisterGPPSMSeg.
- *! 02-Apr-2001 rr: CHNL_Create failure is printed out.
- *! 15-Jan-2001 jeh Removed call to IO_OnLoaded() from DEV_Create2().
- *! 13-Feb-2001 kc: DSP/BIOS Bridge name update.
- *! 15-Dec-2000 rr: Dev_Create2 returns error if NODE_CreateMgr fails.
- *! 05-Dec-2000 jeh Moved IO_OnLoaded() to PROC_Load. Added DEV_SetMsgMgr.
- *! 05-Dev-2000 ag  SM Heap for messaging registered via CMM_RegisterGPPSMSeg().
- *!                 SM heap base and size currently taken from registry.
- *! 29-Nov-2000 rr: Incorporated code review changes.
- *! 17-Nov-2000 jeh Added calls to get IO manager (IO_Create), IO_OnLoaded().
- *! 06-Oct-2000 rr: DEV_Destroy2 and DEV_Create2 added.
- *! 02-Oct-2000 rr: DEV_GetNodeManager added.
- *! 11-Aug-2000 ag: Added DEV_GetCmmMgr(), CMM_Init() & CMM_Exit().
- *!                 Removed <dspbridge/std.h> & <stdwin.h>, added <dspbridge/dbtype.h>
- *! 10-Aug-2000 rr: DEV_InsertProcObject/RemoveProcObject added.
- *!                 DEV_Cleanup calls PROC_Detach if it is a matching process.
- *! 27-Jul-2000 rr: DEV is in new directoy DEV and produces devlib.lib
- *! 17-Jul-2000 rr: DRV Object holds the list of Dev Objects. DEV gets
- *!                 the List and Next devices through DRV.
- *!                 DEV object has a back pointer to DRV Object.
- *! 06-Jun-2000 jeh Added DEV_GetSymbol().
- *! 09-May-2000 rr: dwMemBase has index for multiple windows need.
- *! 28-Feb-2000 rr: New GT Usage implemented.
- *! 03-Feb-2000 rr: GT and Module init/exit Changes.(Done up front from
- *!		    SERVICES)
- *! 31-Jan-2000 rr: Comments changed after code review.
- *! 21-Jan-2000 rr: windows.h, tchar.h, HMODULE removed. FreeLibrary replaced
- *!                 with LDR_FreeModule
- *! 17-Jan-2000 rr: CFG_Get/SetPrivateDword renamed to CFG_Get/SetDevObject.
- *!                 StoreInterfaceFxns stores the new fxn WMD_BRD_SETSTATE.
- *! 20-Nov-1999 ag: Actual uSMLength =  total - monitor offset.
- *! 12-Nov-1999 rr: bIRQ and IRQAttrib taken from the struct CFG_HOSTRES.
- *!		    dMemBase is added with offset for monitor taken from
- *!		    registry.
- *! 31-Oct-1999 ag: Added CHNL support.
- *! 10-Sep-1999 rr: GT Enabled. DEV_Create will Load the Mini Driver and will
- *!                 find its fxn table. Right now lot of things are hardcoded
- *!                 as the REG is not ready.
- *! 10-Jun-1996 rr: Created from WSX
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index be1567a..6b39ead 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -43,15 +43,6 @@
  *      Region: Generic memory entitiy having a start address and a size
  *      Chunk:  Reserved region
  *
- *
- *! Revision History:
- *! ================
- *! 04-Jun-2008 Hari K : Optimized DMM implementation. Removed linked list
- *!                                and instead used Table approach.
- *! 19-Apr-2004 sb: Integrated Alan's code review updates.
- *! 17-Mar-2004 ap: Fixed GetRegion for size=0 using tighter bound.
- *! 20-Feb-2004 sb: Created.
- *!
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index cdfe0dc..61597d7 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -30,11 +30,6 @@
  *  Notes:
  *      This interface is basically a pass through to the WMD IO functions.
  *
- *! Revision History:
- *! ================
- *! 24-Feb-2003 swa 	PMGR Code review comments incorporated.
- *! 04-Apr-2001 rr      WSX_STATUS initialized in IO_Create.
- *! 07-Nov-2000 jeh     Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/pmgr/ioobj.h b/drivers/dsp/bridge/pmgr/ioobj.h
index f473a63..3cf82c8 100644
--- a/drivers/dsp/bridge/pmgr/ioobj.h
+++ b/drivers/dsp/bridge/pmgr/ioobj.h
@@ -24,10 +24,6 @@
  *  Public Functions:
  *      None.
  *
- *! Revision History:
- *! ================
- *! 24-Feb-2003 swa PMGR Code review comments incorporated.
- *! 01/16/97 gp: Created from chnlpriv.h
  */
 
 #ifndef IOOBJ_
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index bbf5174..9bb1024 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -26,13 +26,6 @@
  *      MSG_Exit
  *      MSG_Init
  *
- *! Revision History:
- *! =================
- *! 24-Feb-2003 swa 	PMGR Code review comments incorporated.
- *! 15-May-2001 ag      Changed SUCCEEDED to DSP_SUCCEEDED.
- *! 16-Feb-2001 jeh     Fixed some comments.
- *! 15-Dec-2000 rr      MSG_Create returns DSP_EFAIL if pfnMsgCreate fails.
- *! 12-Sep-2000 jeh     Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/pmgr/msgobj.h b/drivers/dsp/bridge/pmgr/msgobj.h
index 63d025b..bce66d0 100644
--- a/drivers/dsp/bridge/pmgr/msgobj.h
+++ b/drivers/dsp/bridge/pmgr/msgobj.h
@@ -24,10 +24,6 @@
  *  Public Functions:
  *      None.
  *
- *! Revision History:
- *! ================
- *! 24-Feb-2003 swa 	PMGR Code review comments incorporated.
- *! 17-Nov-2000 jeh     Created.
  */
 
 #ifndef MSGOBJ_
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 859043d..a04f40f 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -27,68 +27,6 @@
  *      WCD_Exit
  *      <MOD>WRAP_*
  *
- *! Revision History:
- *! ================
- *! 29-Apr-2004 hp  Call PROC_AutoStart only for DSP device
- *! 19-Apr-2004 sb  Aligned DMM definitions with Symbian
- *! 08-Mar-2004 sb  Added the Dynamic Memory Mapping APIs
- *! 03-Apr-2003 sb  Process environment pointer in PROCWRAP_Load
- *! 24-Feb-2003 swa PMGR Code review comments incorporated.
- *! 30-Jan-2002 ag  CMMWRAP_AllocBuf name changed to CMMWRAP_CallocBuf
- *! 15-Jan-2002 ag  Added actual bufSize param to STRMWRAP_Reclaim[issue].
- *! 14-Dec-2001 rr  ARGS_NODE_CONNECT maps the pAttr.
- *! 03-Oct-2001 rr  ARGS_NODE_ALLOCMSGBUF/FREEMSGBUF maps the pAttr.
- *! 10-Sep-2001 ag  Added CMD_CMM_GETHANDLE.
- *! 23-Apr-2001 jeh Pass pStatus to NODE_Terminate.
- *! 11-Apr-2001 jeh STRMWRAP_Reclaim embedded pointer is mapped and unmapped.
- *! 13-Feb-2001 kc: DSP/BIOS Bridge name updates.
- *! 06-Dec-2000 jeh WRAP_MAP2CALLER pointers in RegisterNotify calls.
- *! 05-Dec-2000 ag: Removed MAP2CALLER in NODEWRAP_FreeMsgBuf().
- *! 22-Nov-2000 kc: Added MGRWRAP_GetPerf_Data().
- *! 20-Nov-2000 jeh Added MSG_Init()/MSG_Exit(), IO_Init()/IO_Exit().
- *!		 WRAP pointers to handles for PROC_Attach, NODE_Allocate.
- *! 27-Oct-2000 jeh Added NODEWRAP_AllocMsgBuf, NODEWRAP_FreeMsgBuf. Removed
- *!		 NODEWRAP_GetMessageStream.
- *! 12-Oct-2000 ag: Added user CMM wrappers.
- *! 05-Oct-2000 rr: WcdInitComplete2 will fail even if one BRD or PROC
- *!		 AutoStart fails.
- *! 25-Sep-2000 rr: Updated to Version 0.9
- *! 13-Sep-2000 jeh Pass ARGS_NODE_CONNECT.pAttrs to NODE_Connect().
- *! 11-Aug-2000 rr: Part of node enabled.
- *! 31-Jul-2000 rr: UTIL_Wrap and MEM_Wrap added to RM.
- *! 27-Jul-2000 rr: PROCWRAP, NODEWRAP and STRMWRAP implemented.
- *!		 STRM and some NODE Wrappers are not implemented.
- *! 27-Jun-2000 rr: MGRWRAP fxns added.IFDEF to build for PM or DSP/BIOS Bridge
- *! 08-Feb-2000 rr  File name changed to wcd.c
- *! 03-Feb-2000 rr: Module initialization are done by SERVICES init. GT Class
- *!		 changes for module init/exit fxns.
- *! 24-Jan-2000 rr: Merged with Scott's code.
- *! 21-Jan-1999 sg: Changed ARGS_CHNL_GETMODE field name from pdwMode to pMode.
- *! 17-Jan-2000 rr: BRD_GetStatus does WRAP_MAP2CALLER for state.
- *! 14-Dec-1999 ag: Removed _MAP2CALLER in CHNL_GetMgr().
- *! 13-Dec-1999 rr: BRDWRAP_GetSymbol, BRDWRAP_GetTrace uses WRAP_MAP2CALLER
- *!		 macros.BRDWRAP_Load maps and unmaps embedded pointers.
- *! 10-Dec-1999 ag: User CHNL bufs mapped in _AddIOReq & _GetIOCompletion.
- *! 09-Dec-1999 rr: BRDWRAP_Open and CHNLWRAP_GetMgr does not map
- *!		 pointer as there was a change in config.c
- *! 06-Dec-1999 rr: BRD_Read and Write Maps the buf pointers.
- *! 03-Dec-1999 rr: CHNLWRAP_GetMgr and BRDWRAP_Open maps  hDevNode pointer.
- *!		 WCD_InitComplete2 Included for BRD_AutoStart.
- *! 16-Nov-1999 ag: Map buf to process in CHNLWRAP_AllocBuffer().
- *!		 CHNL_GetMgr() Mapping Fix.
- *! 10-Nov-1999 ag: Removed unnecessary calls to WRAP_MAP2CALLER.
- *! 08-Nov-1999 kc: Added MEMRY & enabled BRD_IOCtl for tests.
- *! 29-Oct-1999 ag: Added CHNL.
- *! 29-Oct-1999 kc: Added trace statements; added ptr mapping; updated
- *!		 use of UTIL module API.
- *! 29-Oct-1999 rr: Wrapper functions does the Mapping of the Pointers.
- *!		 in WinCE all the explicit pointers will be converted
- *!		 by the OS during interprocess but not the embedded pointers.
- *! 16-Oct-1999 kc: Code review cleanup.
- *! 07-Oct-1999 kc: Added UTILWRAP_TestDll() to run PM test harness. See
- *!		 /src/doc/pmtest.doc for more detail.
- *! 09-Sep-1999 rr: After exactly two years(!). Adopted for WinCE. GT Enabled.
- *! 09-Sep-1997 gp: Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index ae7e641..d9b81ce 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -27,38 +27,6 @@
  *      DCD_AutoRegister, DCD_AutoUnregister, and NLDR module all use
  *      DCD_GetObjects.
  *
- *! Revision History
- *! ================
- *! 03-Dec-2003 map Changed DCD_OBJTYPE to DSP_DCDOBJTYPE
- *! 17-Dec-2002 map Modified DCD_GetDepLibs, DCD_GetNumDepLibs, GetDepLibInfo
- *!                 to include phase information
- *! 02-Dec-2002 map Modified DCD_GetLibraryName for phases in different
- *!                 libraries
- *! 26-Feb-2003 kc  Updated DCD_AutoUnregister and DCD_GetObjects to simplify
- *!                 DCD implementation.
- *! 17-Jul-2002 jeh Call COD_Open() instead of COD_OpenBase(), call COD_Close()
- *! 11-Jul-2002 jeh Added DCD_GetDepLibs(), DCD_GetNumDepLibs().
- *! 18-Feb-2003 vp  Code review updates
- *! 18-Oct-2002 vp  Ported to Linux platform
- *! 15-Mar-2002 jeh Read dynamic loading memory requirements into node object
- *!                 data. Added DCD_GetLibraryName().
- *! 13-Feb-2002 jeh Get system stack size in GetAttrsFromBuf().
- *! 01-Aug-2001 ag: Added check for PROC "extended" attributes used for
- *!                    DSP-MMU setup. These are private attributes.
- *! 18-Apr-2001 jeh Use COD_OpenBase instead of COD_LoadBase.
- *! 03-Apr-2001 sg: Changed error names to DSP_EDCD* format.
- *! 11-Jan-2001 jeh Changes to DCD_GetObjectDef to match node.cdb, proc.cdb.
- *! 12-Dec-2000 kc: Added DCD_AutoUnregister. MSGNODE, DAISNODE added in
- *!                 GetAttrsFromBuf
- *! 22-Nov-2000 kc: Replaced sprintf() calls with strncat.
- *! 09-Nov-2000 kc: Optimized DCD module.
- *! 30-Oct-2000 kc: Added DCD_AutoRegister function; changed local var. names.
- *! 29-Sep-2000 kc: Added code review changes (src/reviews/dcd_reviews.txt).
- *! 06-Sep-2000 jeh Get message segid, message notification type. Added Atoi()
- *!                 to replace atoi(), until cdb generation can output in
- *!                 decimal format.
- *! 26-Jul-2000 kc: Created.
- *!
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 3fbbf01..6896e45 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -33,17 +33,6 @@
  *      DISP_NodePause
  *      DISP_NodeRun
  *
- *! Revision History:
- *! =================
- *! 18-Feb-2003 vp      Code review updates
- *! 18-Oct-2002 vp      Ported to Linux platform
- *! 16-May-2002 jeh     Added DISP_DoCinit().
- *! 24-Apr-2002 jeh     Added DISP_MemWrite().
- *! 13-Feb-2002 jeh     Pass system stack size to RMS.
- *! 16-Jan-2002  ag     Added bufsize param to _ChnlAddIOReq() fxn
- *! 10-May-2001 jeh     Code Review cleanup.
- *! 26-Sep-2000 jeh     Fixed status values in SendMessage().
- *! 19-Jun-2000 jeh     Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 9ab0ef4..c7f66e6 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -35,59 +35,6 @@
  *      DRV_RequestResources
  *      DRV_ReleaseResources
  *
- *! Revision History
- *! ======== ========
- *! 19-Apr-2004 sb: Replaced OS specific APIs with MEM_AllocPhysMem and
-		    MEM_FreePhysMem. Fixed warnings. Cosmetic updates.
- *! 12-Apr-2004 hp: IVA clean up during bridge-uninstall
- *! 05-Jan-2004 vp: Updated for 24xx platform
- *! 21-Mar-2003 sb: Get SHM size from registry
- *! 10-Feb-2003 vp: Code review updates
- *! 18-Oct-2002 vp: Ported to Linux platform
- *! 30-Oct-2000 kc: Modified usage of REG_SetValue.
- *! 06-Sep-2000 jeh Read channel info into struct CFG_HOSTRES in
- *! 					RequestISAResources()
- *! 21-Sep-2000 rr: numwindows is calculated instead of default value in
- *!		 RequestISAResources.
- *! 07-Aug-2000 rr: static list of dev objects removed.
- *! 27-Jul-2000 rr: RequestResources split into two(Request and Release)
- *!		 Device extension created to hold the DevNodeString.
- *! 17-Jul-2000 rr: Driver Object holds the list of Device Objects.
- *!		 Added DRV_Create, DRV_Destroy, DRV_GetDevObject,
- *!		 DRV_GetFirst/NextDevObject, DRV_Insert/RemoveDevObject.
- *! 09-May-2000 rr: PCI Support is not L301 specific.Use of MEM_Calloc
- *!		 instead of MEM_Alloc.
- *! 28-Mar-2000 rr: PCI Support added. L301 Specific. TBD.
- *! 03-Feb-2000 rr: GT and Module Init/exit Changes. Merged with kc.
- *! 19-Jan-2000 rr: DBC_Ensure in RequestPCMCIA moved within PCCARD ifdef
- *! 29-Dec-1999 rr: PCCard support for any slot.Bus type stored in the
- *!		 struct CFG_HOSTRES Structure.
- *! 17-Dec-1999 rr: if PCCARD_Init fails we return DSP_EFAIL.
- *!		 DBC_Ensure checks for sucess and pDevice != NULL
- *! 11-Dec-1999 ag: #define "Isa" renamed to "IsaBus".
- *! 09-Dec-1999 rr: windows.h included to remove warnings.
- *! 02-Dec-1999 rr: struct GT_Mask is with in if DEBUG. Request resources checks
- *!		 status while making call to Reg functions.
- *! 23-Nov-1999 rr: windows.h included
- *! 19-Nov-1999 rr: DRV_RELEASE bug while setting the registry to zero.
- *!		 fixed.
- *! 12-Nov-1999 rr: RequestResources() reads values from the registry.
- *!		 Hardcoded bIRQRegister define removed.
- *! 05-Nov-1999 rr: Added hardcoded device interrupt.
- *! 25-Oct-1999 rr: Resource structure removed. Now it uses the Host
- *!		 Resource structure directly.
- *! 15-Oct-1999 rr: Resource Structure modified. See drv.h
- *!		 dwBusType taken from the registry.Hard coded
- *!		 registry entries removed.
- *! 05-Oct-1999 rr: Calling DEV_StartDevice moved to wcdce.c. DRV_Register
- *!		 MiniDriver has been renamed to DRV_RequestResources.
- *!		 DRV_UnRegisterMiniDriver fxn removed.
- *! 24-Sep-1999 rr: Significant changes to the RegisterMiniDriver fxns.
- *!		 Now it is simpler. IT stores the dev node in the
- *!		 registry, assign resources and calls the DEV_Start.
- *! 10-Sep-1999 rr: Register Minidriver modified.
- *!		 - Resource structure follows the NT model
- *! 08-Aug-1999 rr: Adopted for WinCE. Exports Fxns removed. Hull Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a283cd7..550a967 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -27,21 +27,6 @@
  *      driver_ioctl
  *      driver_mmap
  *
- *! Revision History
- *! ================
- *! 21-Apr-2004 map   Deprecated use of MODULE_PARM for kernel versions
- *!		   greater than 2.5, use module_param.
- *! 08-Mar-2004 sb    Added the dsp_debug argument, which keeps the DSP in self
- *!		   loop after image load and waits in a loop for DSP to start
- *! 16-Feb-2004 vp    Deprecated the usage of MOD_INC_USE_COUNT and
- *! 						MOD_DEC_USE_COUNT
- *!		   for kernel versions greater than 2.5
- *! 20-May-2003 vp    Added unregister functions for the DPM.
- *! 24-Mar-2003 sb    Pass pid instead of driverContext to DSP_Close
- *! 24-Mar-2003 vp    Added Power Management support.
- *! 21-Mar-2003 sb    Configure SHM size using insmod argument shm_size
- *! 10-Feb-2003 vp    Updated based on code review comments
- *! 18-Oct-2002 sb    Created initial version
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.h b/drivers/dsp/bridge/rmgr/drv_interface.h
index f5b068e..c7ed602 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.h
+++ b/drivers/dsp/bridge/rmgr/drv_interface.h
@@ -18,12 +18,6 @@
 /*
  *  ======== drv_interface.h ========
  *
- *! Revision History
- *! ================
- *! 24-Mar-2003 vp  Added hooks for Power Management Test
- *! 18-Feb-2003 vp  Code review updates
- *! 18-Oct-2002 sb  Created initial version
-
  */
 
 #ifndef	_DRV_INTERFACE_H_
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index a7a74fc..243547b 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -20,75 +20,6 @@
  *  Description:
  *      Interface to allocate and free bridge resources.
  *
- *! Revision History
- *! ================
- *! 12-Apr-2004 hp: Compile IVA only for 24xx.
- *! 09-Feb-2004 vp: Updated to support IVA.
- *! 10-Feb-2003 vp: Code review updates.
- *! 18-oct-2002 vp: Ported to the Linux platform.
- *! 03-Mar-2002 rr: DSP_Deinit bug fixed (gets the Mgrhandle from registry
- *!		            before calling MGR_Destroy.
- *! 11-Jul-2001 jeh Moved MGR_Create() from DSP_Init() to DEV_StartDevice().
- *! 02-Apr-2001 rr: WCD_InitComplete2 return value is not checked thus
- *!                 sllowing the class driver to load irrespective of
- *!                 the image load.
- *! 30-Oct-2000 kc: Made changes w.r.t. usage of REG_SetValue.
- *! 05-Oct-2000 rr: WCD_InitComplete2 return value checked for RM.
- *!                 Failure in WCD_InitComplete2 will cause the
- *!                 DSP_Init to fail.
- *! 12-Aug-2000 kc: Changed REG_EnumValue to REG_EnumKey.
- *! 07-Aug-2000 rr: MGR_Create does the job of loading the DCD Dll.
- *! 26-Jul-2000 rr: Driver Object holds the DevNodeStrings for each
- *!                 DevObjects. Static variables removed. Returns
- *!                 the Driver Object in DSP_Init.
- *! 17-Jul-2000 rr: Driver Object is created in DSP_Init and that holds
- *!                 the list of Device objects.
- *! 07-Jul-2000 rr: RM implementaion started.
- *! 24-May-2000 ag: Cleaned up debug msgs.
- *! 02-May-2000 rr: DSP_Open returns GetCallerProcess as dwOpenContext.
- *! 03-Feb-2000 rr: GT Changes.
- *! 28-Jan-2000 rr: Code Cleaned up.Type void changed to void.
- *!                 DSP_Deinit checks return values.dwCode in
- *!                 DSP_IO_CONTROL is decoded(not hard coded)
- *! 27-Jan-2000 rr: REG_EnumValue Used .EnumerateKey fxn removed.
- *! 13-Jan-2000 rr: CFG_GetPrivateDword renamed to CFG_GetDevObject.
- *! 29-Dec-1999 rr: Code Cleaned up
- *! 09-Dec-1999 rr: EnumerateKey changed for retail build.
- *! 06-Dec-1999 rr: ArrayofInstalledNode, index and  ArrayofInstalledDev
- *!                 is Global.DevObject stores this pointer as hDevNode.
- *! 02-Dec-1999 rr: DBG_SetGT and RetailMSG conditionally included.
- *!                 Comments changed.Deinit handled.Code cleaned up.
- *!                 DSP_IOControl, Close, Deinit returns bool values.
- *!                 Calls WCD_InitComplete2 for Board AutoStart.
- *! 29-Nov-1999 rr: DSP_IOControl returns the result through pBufOut.
- *!                 Global Arrays keeps track of installed devices.
- *! 19-Nov-1999 rr: DSP_Init handles multiple drivers.
- *! 12-Nov-1999 rr: GetDriverKey and EnumerateKey functions added.
- *!                 for multiple mini driver support.PCCARD flag
- *!                 checking to include PCMCIA related stuff.
- *! 25-Oct-1999 rr: GT_Init is called within the Process Attach.
- *!                 return value initalized to S_OK upfront in the
- *!                 Process Attach.
- *! 15-Oct-1999 rr: DSP_DeInit handles the return values
- *! 05-Oct-1999 rr: All the PCMCIA related functions are now in PCCARD.c
- *!                 DRV_Request Resources is used instead of the
- *!                 RegisterMiniDriver as it sounds close to what we are doing.
- *! 24-Sep-1999 rr: DRV_RegisterMiniDriver is being called from here. Only
- *!                 neccessaryPCMCIA fxns are here. Soon they will move out
- *!                  either to a seperate file for bus specific inits.
- *! 10-Sep-1999 rr: GT Enabled. Considerably changed the  driver structure as
- *!                 - This is the Class driver. After successfully initialized
- *!                   the Class driver will attempt to load the Mini driver.
- *!                 - Need to seperate the PCMCIA stuff based on bus type.
- *!                 - Changed the name of the file to wcdce.c
- *!                 - Made the Media Handle as Global again
- *!
- *! 19-Aug-1999 rr: Removed the Global hbhMediaHandle. Included the MemTest.
- *!                 Modified the DSP_Init, now three windows are opened.
- *!                 Split the driver into PDD so that hardware dependent
- *!                 functions will reside in PDD.
- *! 16-Jul-1999 ag  Adapted from rkw's CAC Bullet card driver.
- *!
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 943cf93..bfdf01b 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -22,22 +22,6 @@
  *      driver level. This queries the NDB data base and retrieves the
  *      data about Node and Processor.
  *
- *
- *! Revision History:
- *! ================
- *! 12-Feb-2003 vp: Code review updates.
- *! 18-Oct-2002 vp: Ported to Linux platform
- *! 01-Aug-2001 ag: Added extended info for DSP-MMU setup support.
- *! 13-Feb-2001 kc: DSP/BIOS Bridge name updates.
- *! 22-Nov-2000 kc: Added MGR_GetPerfData.
- *! 03-Nov-2000 rr: Updated after code review.
- *! 25-Sep-2000 rr: Updated to Version 0.9
- *! 10-Aug-2000 rr: dwSignature is not specifically inserted in MGR Obj
- *!                 as it is taken care by MEM_AllocObject. stdwin.h added
- *!                 for retail build to succeed.
- *! 07-Aug-2000 rr: MGR_Create does the job of Loading DCD Dll.
- *! 26-Jul-2000 rr: MGR_Destroy releases the hNDBDll.
- *! 20-Jun-2000 rr: Created.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index f3c429c..ca63c3e 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -33,21 +33,6 @@
  *
  *  Notes:
  *
- *! Revision History
- *! ================
- *! 07-Apr-2003 map Removed references to dead DLDR module
- *! 23-Jan-2003 map Updated RemoteAlloc to support memory granularity
- *! 20-Jan-2003 map Updated to maintain persistent dependent libraries
- *! 15-Jan-2003 map Adapted for use with multiple dynamic phase libraries
- *! 19-Dec-2002 map Fixed overlay bug in AddOvlySect for overlay
- *!		 sections > 1024 bytes.
- *! 13-Dec-2002 map Fixed NLDR_GetFxnAddr bug by searching dependent
- *!		 libs for symbols
- *! 27-Sep-2002 map Added RemoteFree to convert size to words for
- *!		 correct deallocation
- *! 16-Sep-2002 map Code Review Cleanup(from dldr.c)
- *! 29-Aug-2002 map Adjusted for ARM-side overlay copy
- *! 05-Aug-2002 jeh Created.
  */
 
 #include <dspbridge/host_os.h>
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index dbca4bf..b04e980 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -44,52 +44,6 @@
  *      NODE_Run
  *      NODE_Terminate
  *
- *! Revision History:
- *! =================
- *! 12-Apr-2004 hp  Compile IVA only for 24xx
- *! 09-Feb-2004 vp  Updated to support IVA.
- *! 07-Apr-2003 map	    Eliminated references to old DLDR
- *! 26-Mar-2003 vp  Commented the call to DSP deep sleep in Node_Delete
- *!		    function.
- *! 18-Feb-2003 vp  Code review updates.
- *! 06-Feb-2003 kc      Fixed FreeStream to release streams correctly.
- *! 23-Jan-2003 map     Removed call to DISP_DoCinit within Write()
- *! 03-Jan-2003 map     Only unload code after phase has executed if
- *!		     overlay or split dynload phases
- *! 18-Oct-2002 vp  Ported to Linux platform.
- *! 06-Nov-2002 map     Fixed NODE_Run on NODE_PAUSED bug
- *! 12-Oct-2002 map     Fixed DeleteNode bug in NODE_Create
- *! 11-Sep-2002 rr      DeleteNode frees the memory for strmConnect and dcd obj
- *! 29-Aug-2002 map     Modified Ovly and Write to use ARM-side copy
- *! 22-May-2002 sg      Changed use of cbData for PWR calls.
- *! 17-May-2002 jeh     Removed LoadLoaderFxns(). Get address of RMS_cinit()
- *!		     function. Call DISP_DoCinit() from Write(), if .cinit.
- *! 13-May-2002 sg      Added timeout to wake/sleep calls.
- *! 02-May-2002 sg      Added wake/sleep of DSP to support "nap" mode.
- *! 18-Apr-2002 jeh     Use dynamic loader if compile flag is set.
- *! 13-Feb-2002 jeh     Get uSysStackSize from DSP_NDBPROPS.
- *! 07-Jan-2002 ag      STRMMODE_ZEROCOPY(shared memory buffer swap) enabled.
- *! 17-Dec-2001 ag      STRMMODE_RDMA(DDMA) enabled.
- *! 12-Dec-2001 ag      Check for valid stream mode in NODE_Connect().
- *! 04-Dec-2001 jeh     Check for node sufficiently connected in NODE_Create().
- *! 15-Nov-2001 jeh     Removed DBC_Require(pNode->hXlator != NULL) from
- *!		     NODE_AllocMsgBuf(), and check node type != NODE_DEVICE.
- *! 11-Sep-2001 ag      Zero-copy messaging support.
- *! 28-Aug-2001 jeh     Overlay/dynamic loader infrastructure added. Removed
- *!		     NODE_GetDispatcher, excess node states.
- *! 07-Aug-2001 jeh     Removed critical section for dispatcher.
- *! 26-Jul-2001 jeh     Get ZL dll name through CFG.
- *! 05-Jun-2001 jeh     Assume DSP_STRMATTRS.uBufsize in GPP bytes.
- *! 11-May-2001 jeh     Some code review cleanup.
- *! 13-Feb-2001 kc:     DSP/BIOS Bridge name updates.
- *! 15-Dec-2000 sg      Convert IALG_Fxn address from byte addr to word addr.
- *! 04-Dec-2000 jeh     Call MSG Get and Put functions.
- *! 04-Dec-2000 ag      Added SM support for node messaging.
- *! 10-Nov-2000 rr:     NODE_MIN/MAX Priority is defined in dspdefs.h.
- *! 27-Oct-2000 jeh     Added NODE_AllocMsgBuf(), NODE_FreeMsgBuf().
- *! 11-Oct-2000 jeh     Changed NODE_EnumNodeInfo to NODE_EnumNodes. Added
- *!		     NODE_CloseOrphans(). Remove NODE_RegisterNotifyAllNodes
- *! 19-Jun-2000 jeh     Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 8270af9..180559b 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -42,62 +42,6 @@
  *      PROC_UnReserveMemory
  *      PROC_InvalidateMemory
 
- *! Revision History
- *! ======== ========
- *! 04-Apr-2007 sh  Added PROC_InvalidateMemory API
- *! 19-Apr-2004 sb  Aligned DMM definitions with Symbian
- *!		 Used MEM_FlushCache instead of OS specific API
- *!		 Integrated Alan's code review updates
- *! 08-Mar-2004 sb  Added the Dynamic Memory Mapping feature
- *! 08-Mar-2004 vp  Added g_pszLastCoff member to PROC_OBJECT.
- *!		 This is required for multiprocessor environment.
- *! 09-Feb-2004 vp  Added PROC_GetProcessorID function
- *! 22-Apr-2003 vp  Fixed issue with the string that stores coff file name
- *! 03-Apr-2003 sb  Fix DEH deregistering bug
- *! 26-Mar-2003 vp  Commented the call to DSP deep sleep in PROC_Start function.
- *! 18-Feb-2003 vp  Code review updates.
- *! 18-Oct-2002 vp  Ported to Linux platform.
- *! 22-May-2002 sg  Do IOCTL-to-PWR translation before calling PWR_SleepDSP.
- *! 14-May-2002 sg  Use CSL_Atoi() instead of atoi().
- *! 13-May-2002 sg  Propagate PWR return codes upwards.
- *! 07-May-2002 sg  Added check for, and call to PWR functions in PROC_Ctrl.
- *! 02-May-2002 sg  Added "nap" mode: put DSP to sleep once booted.
- *! 01-Apr-2002 jeh Assume word addresses in PROC_GetTrace().
- *! 29-Nov-2001 jeh Don't call DEH function if hDehMgr == NULL.
- *! 05-Nov-2001 kc: Updated PROC_RegisterNotify and PROC_GetState to support
- *!		 DEH module.
- *! 09-Oct-2001 jeh Fix number of bytes calculated in PROC_GetTrace().
- *! 11-Sep-2001 jeh Delete MSG manager in PROC_Monitor() to fix memory leak.
- *! 29-Aug-2001 rr: DCD_AutoRegister and IOOnLoaded moved before COD_LoadBase
- *!		 to facilitate the external loading.
- *! 14-Aug-2001 ag  DCD_AutoRegister() now called before IOOnLoaded() fxn.
- *! 21-Jun-2001 rr: MSG_Create is done only the first time.
- *! 02-May-2001 jeh Return failure in PROC_Load if IOOnLoaded function returns
- *!		 error other than E_NOTIMPL.
- *! 03-Apr-2001 sg: Changed DSP_DCD_ENOAUTOREGISTER to DSP_EDCDNOAUTOREGISTER.
- *! 13-Feb-2001 kc: DSP/BIOS Bridge name updates.
- *! 05-Jan-2001 rr: PROC_LOAD MSG_Create error is checked.
- *! 15-Dec-2000 rr: IoOnLoaded is checked for WSX_STATUS. We fail to load
- *!		 if DEV_Create2 fails; ie, no non-RMS targets can be
- *!		 loaded.
- *! 12-Dec-2000 rr: PROC_Start's DEV_Create2 is checked for WSX_STATUS.
- *! 28-Nov-2000 jeh Added call to IO OnLoaded function to PROC_Load().
- *! 29-Nov-2000 rr: Incorporated code review changes.
- *! 03-Nov-2000 rr: Auto_Register happens after PROC_Load.
- *! 06-Oct-2000 rr: Updated to ver 0.9. PROC_Start calls DEV_Create2 and
- *!		 WMD_BRD_STOP is always followed by DEV_Destroy2.
- *! 05-Sep-2000 rr: PROC_GetTrace calculates the Trace symbol for 55 in a
- *!		 different way.
- *! 10-Aug-2000 rr: PROC_NotifyClients, PROC_GetProcessorHandle Added
- *! 07-Aug-2000 rr: PROC_IDLE/SYNCINIT/UNKNOWN state removed.
- *!		 WMD fxns are checked for WSX_STATUS.
- *!		 PROC_Attach does not alter the state of the BRD.
- *!		 PROC_Run removed.
- *! 04-Aug-2000 rr: All the functions return DSP_EHANDLE if proc handle is
- *!		 invalid
- *! 27-Jul-2000 rr: PROC_GetTrace and PROC_Load implemented. Updated to
- *!		 ver 0.8 API.
- *! 06-Jul-2000 rr: Created.
  */
 
 /* ------------------------------------ Host OS */
diff --git a/drivers/dsp/bridge/rmgr/pwr.c b/drivers/dsp/bridge/rmgr/pwr.c
index 50a3f79..ce05019 100644
--- a/drivers/dsp/bridge/rmgr/pwr.c
+++ b/drivers/dsp/bridge/rmgr/pwr.c
@@ -23,12 +23,6 @@
  *      PWR_SleepDSP
  *      PWR_WakeDSP
  *
- *! Revision History
- *! ================
- *! 18-Feb-2003 vp  Code review updates.
- *! 18-Oct-2002 vp  Ported to Linux platform.
- *! 22-May-2002 sg  Do PWR-to-IOCTL code mapping in PWR_SleepDSP.
- *! 29-Apr-2002 sg  Initial.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index 575f675..47ad002 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -40,15 +40,6 @@
  *  overlayed from being overwritten as long as the memory it runs at has
  *  been allocated, and not yet freed.
  *
- *! Revision History
- *! ================
- *! 18-Feb-2003 vp  Code review updates.
- *! 18-Oct-2002 vp  Ported to Linux Platform.
- *! 24-Sep-2002 map Updated from Code Review
- *! 25-Jun-2002 jeh     Free from segid passed to RMM_free().
- *! 24-Apr-2002 jeh     Determine segid based on address in RMM_free(). (No way
- *!                     to keep track of segid with dynamic loader library.)
- *! 16-Oct-2001 jeh     Based on gen tree rm.c. Added support for overlays.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index bd55fd3..9a006cf 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -41,24 +41,6 @@
  *
  *  Notes:
  *
- *! Revision History:
- *! =================
- *! 18-Feb-2003 vp  Code review updates.
- *! 18-Oct-2002 vp  Ported to Linux platform.
- *! 13-Mar-2002 map    pStrm init'd to NULL in STRM_Open to prevent error
- *! 12-Mar-2002 map Changed return var to WSX "wStatus" instead of "status"
- *!		    in DEV and CMM function calls to avoid confusion.
- *!		    Return DSP_SOK instead of S_OK from API fxns.
- *! 12-Mar-2002 map    Changed FAILED(..) to DSP_FAILED(..)
- *! 25-Jan-2002 ag  Allow neg seg ids(e.g. DSP_SHMSEG0) to denote SM.
- *! 15-Nov-2001 ag  Added STRMMODE & SM for DMA/ZCopy streaming.
- *!		 Changed DSP_STREAMINFO to STRM_INFO in STRM_GetInfo().
- *!		 Use strm timeout value for dma flush timeout.
- *! 09-May-2001 jeh Code review cleanup.
- *! 06-Feb-2001 kc  Updated DBC_Ensure in STRM_Select to check timeout.
- *! 23-Oct-2000 jeh Allow NULL STRM_ATTRS passed to STRM_Open() for DLL
- *!		 tests to pass.
- *! 25-Sep-2000 jeh Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 67656bf..946dcf7 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -32,44 +32,6 @@
  *      CFG_SetDevObject
  *      CFG_SetObject
  *
- *
- *! Revision History:
- *! ================
- *! 26-Arp-2004 hp  Support for handling more than one Device.
- *! 26-Feb-2003 kc  Removed unused CFG fxns.
- *! 10-Nov-2000 rr: CFG_GetBoardName local var initialized.
- *! 30-Oct-2000 kc: Changed local var. names to use Hungarian notation.
- *! 10-Aug-2000 rr: Cosmetic changes.
- *! 26-Jul-2000 rr: Added CFG_GetDCDName. CFG_Get/SetObject(based on a flag)
- *!                  replaces CFG_GetMgrObject & CFG_SetMgrObject.
- *! 17-Jul-2000 rr: Added CFG_GetMgrObject & CFG_SetMgrObject.
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		    GT Changes.
- *! 31-Jan-2000 rr: Comments and bugfixes:  modified after code review
- *! 07-Jan-2000 rr: CFG_GetBoardName Ensure class checks strlen of the
- *!                 read value from the registry against the passed in BufSize;
- *!                 CFG_GetZLFile,CFG_GetWMDFileName and
- *!                 CFG_GetExecFile also modified same way.
- *! 06-Jan-2000 rr: CFG_GetSearchPath & CFG_GetWinBRIDGEDir removed.
- *! 09-Dec-1999 rr: CFG_SetDevObject stores the DevNodeString pointer.
- *! 03-Dec-1999 rr: CFG_GetDevObject reads stored DevObject from Registry.
- *!                 CFG_GetDevNode reads the Devnodestring from the registry.
- *!                 CFG_SetDevObject stores the registry path as
- *!                 DevNodestring in the registry.
- *! 02-Dec-1999 rr: CFG_debugMask is declared static now. stdwin.h included
- *! 22-Nov-1999 kc: Added windows.h to remove warnings.
- *! 25-Oct-1999 rr: CFG_GetHostResources reads the HostResource structure
- *!                 from the registry which was set by the DRV Request
- *!                 Resources.
- *! 15-Oct-1999 rr: Changes in CFG_SetPrivateDword & HostResources reflecting
- *!                 changes for  drv.h resource structure and wsxreg.h new
- *!                 entry(DevObject) Hard coded entries removed for those items
- *! 08-Oct-1999 rr: CFG_SetPrivateDword modified. it sets devobject into the
- *!                 registry. CFG_Get HostResources modified for opening up
- *!                 two mem winodws.
- *! 24-Sep-1999 rr: CFG_GetHostResources uses hardcoded Registry calls,uses NT
- *!                 type of Resource Structure.
- *! 19-Jul-1999 a0216266: Stubbed from cfgnt.c.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 440706f..e99a748 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -26,10 +26,6 @@
  *	CLK_Disable
  *	CLK_GetRate
  *	CLK_Set_32KHz
- *! Revision History:
- *! ================
- *! 08-May-2007 rg: moved all clock functions from sync module.
- *		    And added CLK_Set_32KHz, CLK_Set_SysClk.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/csl.c b/drivers/dsp/bridge/services/csl.c
index dd33c2d..662e32c 100644
--- a/drivers/dsp/bridge/services/csl.c
+++ b/drivers/dsp/bridge/services/csl.c
@@ -27,27 +27,6 @@
  *      CSL_NumToAscii
  *      CSL_Strtokr
  *
- *! Revision History:
- *! ================
- *! 07-Aug-2002 jeh: Added CSL_Strtokr().
- *! 21-Sep-2001 jeh: Added CSL_Strncmp(). Alphabetized functions.
- *! 22-Nov-2000 map: Added CSL_Atoi and CSL_Strtok
- *! 19-Nov-2000 kc: Added CSL_ByteSwap.
- *! 09-Nov-2000 kc: Added CSL_Strncat.
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 15-Dec-1999 ag: Removed incorrect assertion CSL_NumToAscii()
- *! 29-Oct-1999 kc: Added CSL_Wstrlen for UNICODE strings.
- *! 30-Sep-1999 ag: Removed DBC assertion (!CSL_DebugMask.flags) in
- *		  CSP_Init().
- *! 20-Sep-1999 ag: Added CSL_WcharToAnsi().
- *!		 Removed call to GT_set().
- *! 19-Jan-1998 cr: Code review cleanup.
- *! 29-Dec-1997 cr: Made platform independant, using MS CRT code, and
- *!		 combined csl32.c csl95.c and cslnt.c into csl.c.  Also
- *!		 changed CSL_lowercase to CSL_Uppercase.
- *! 21-Aug-1997 gp: Fix to CSL_strcpyn to initialize Source string, the NT way.
- *! 25-Jun-1997 cr: Created from csl95, added CSL_strcmp.
  */
 
 /* ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/dbg.c b/drivers/dsp/bridge/services/dbg.c
index 5e1773f..3fbe236 100644
--- a/drivers/dsp/bridge/services/dbg.c
+++ b/drivers/dsp/bridge/services/dbg.c
@@ -31,18 +31,6 @@
  *      This implementation does not create GT masks on a per WMD basis.
  *      There is currently no facility for a WMD to alter the GT mask.
  *
- *! Revision History:
- *! ================
- *! 15-Feb-2000 rr: DBG_Trace prints based on the DebugZones.
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 29-Oct-1999 kc: Cleaned up for code review.
- *! 10-Oct-1997 cr: Added DBG_Printf service.
- *! 28-May-1997 cr: Added reference counting.
- *! 23-May-1997 cr: Updated DBG_Trace to new gt interface.
- *! 29-May-1996 gp: Removed WCD_ prefix.
- *! 20-May-1996 gp: Remove DEBUG conditional compilation.
- *! 15-May-1996 gp: Created.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/services/dpc.c b/drivers/dsp/bridge/services/dpc.c
index f943726..62881d2 100644
--- a/drivers/dsp/bridge/services/dpc.c
+++ b/drivers/dsp/bridge/services/dpc.c
@@ -28,20 +28,6 @@
  *      DPC_Init
  *      DPC_Schedule
  *
- *! Revision History:
- *! ================
- *! 28-Mar-2001 ag: Added #ifdef CHNL_NOIPCINTR to set DPC thread priority
- *!                     to THREAD_PRIORITY_IDLE for polling IPC.
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 31-Jan-2000 rr: Changes after code review.Terminate thread,handle
- *!                 modified.DPC_Destroy frees the DPC_Object only on
- *!                 Successful termination of the thread and the handle.
- *! 06-Jan-1999 ag: Format cleanup for code review.
- *!                 Removed DPC_[Lower|Raise]IRQL[From|To]DispatchLevel.
- *! 10-Dec-1999 ag: Added SetProcPermissions in DPC_DeferredProcedure().
- *!                 (Needed to access client(s) CHNL buffers).
- *! 19-Sep-1999 a0216266: Stubbed from dpcnt.c.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/kfile.c b/drivers/dsp/bridge/services/kfile.c
index ba1d26f..f6bff02 100644
--- a/drivers/dsp/bridge/services/kfile.c
+++ b/drivers/dsp/bridge/services/kfile.c
@@ -29,16 +29,6 @@
  *      KFILE_Seek
  *      KFILE_Tell
  *
- *! Revision History
- *! ================
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 22-Nov-1999 kc: Added changes from code review.
- *! 12-Nov-1999 kc: Enabled CSL for UNICODE/ANSI string conversions.
- *! 30-Sep-1999 ag: Changed KFILE_Read() GT level from _ENTER to _4CLASS.
- *!                 Removed GT_set().
- *! 25-Aug-1999 ag: Changed MEM_Calloc allocation type to MEM_PAGED.
- *! 13-Jul-1999 a0216266(ww - TID): Stubbed from kfilent.c.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/list.c b/drivers/dsp/bridge/services/list.c
index 7fa3e76..2135742 100644
--- a/drivers/dsp/bridge/services/list.c
+++ b/drivers/dsp/bridge/services/list.c
@@ -33,18 +33,6 @@
  *      LST_PutTail
  *      LST_RemoveElem
  *
- *! Revision History
- *! ================
- *! 06-Mar-2002 jeh Don't set element self to NULL in LST_RemoveElem().
- *! 10-Aug-2000 ag: Added LST_InsertBefore().
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 22-Nov-1999 kc: Added changes from code review.
- *! 10-Aug-1999 kc: Based on wsx-c18.
- *! 16-Jun-1997 gp: Removed unnecessary enabling/disabling of interrupts around
- *!                 list manipulation code.
- *! 22-Oct-1996 gp: Added LST_RemoveElem, and LST_First/LST_Next iterators.
- *! 10-Aug-1996 gp: Acquired from SMM for WinSPOX v. 1.1; renamed identifiers.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 0a10304..676f674 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -31,24 +31,6 @@
  *      MEM_Init
  *      MEM_ExtPhysPoolInit
  *
- *! Revision History:
- *! =================
- *! 18-Jan-2004 hp: Added support for External physical memory pool
- *! 19-Apr-2004 sb: Added Alloc/Free PhysMem, FlushCache, VirtualToPhysical
- *! 01-Sep-2001 ag: Code cleanup.
- *! 02-May-2001 ag: MEM_[UnMap]LinearAddress revamped to align Phys to Virt.
- *!		 Set PAGE_PHYSICAL if phy addr <= 512MB. Opposite uSoft doc!
- *! 29-Aug-2000 rr: MEM_LinearAddress does not check for 512MB for non-x86.
- *! 28-Mar-2000 rr: MEM_LinearAddress changed.Handles address larger than 512MB
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 22-Nov-1999 kc: Added changes from code review.
- *! 16-Aug-1999 kc: modified for WinCE.
- *! 20-Mar-1999 ag: SP 4 fix in MEM_UMBCalloc().
- *!		 Mdl offset now ORed not added to userBuf.
- *! 23-Dec-1997 cr: Code review changes.
- *! 08-Dec-1997 cr: Prepared for code review.
- *! 24-Jun-1997 cr: Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 2eff3eb..d5e3676 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -28,15 +28,6 @@
  *      NTFY_Notify
  *      NTFY_Register
  *
- *! Revision History:
- *! =================
- *! 06-Feb-2003 kc      Removed DSP_POSTMESSAGE related code.
- *! 05-Nov-2001 kc      Updated DSP_HNOTIFICATION structure.
- *! 10-May-2001 jeh     Removed SERVICES module init/exit from NTFY_Init/Exit.
- *!                     NTFY_Register() returns DSP_ENOTIMPL for all but
- *!                     DSP_SIGNALEVENT.
- *! 12-Oct-2000 jeh     Use MEM_IsValidHandle().
- *! 07-Sep-2000 jeh     Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index 0d85f41..799de12 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -28,9 +28,6 @@
  *      REG_Init
  *      REG_SetValue
  *
- *! Revision History:
- *! ================
- *
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 5251b68..33e18f9 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -20,12 +20,6 @@
  *  Purpose:
  *      Provide registry support functions.
  *
- *! Revision History:
- *! ================
- *! 28-May-2002  map: Integrated PSI's dspimage update mechanism
- *! 11-May-2002  gp:  Turned PERF "on".
- *! 21-May-2002  map: Fixed bug in SetValue - if resizing datasize, set
- *!		      new size too
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/services/regsup.h b/drivers/dsp/bridge/services/regsup.h
index 011be52..a20ecb9 100644
--- a/drivers/dsp/bridge/services/regsup.h
+++ b/drivers/dsp/bridge/services/regsup.h
@@ -18,8 +18,6 @@
 /*
  *  ======== regsup.h ========
  *
- *! Revision History
- *! ================
  */
 
 #ifndef _REGSUP_H_
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 346007e..e602e70 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -24,12 +24,6 @@
  *      SERVICES_Exit
  *      SERVICES_Init
  *
- *
- *! Revision History
- *! ================
- *! 20-Nov-2000 rr: NTFY_Init/Exit added.
- *! 06-Jul-2000 rr: PROC prefix changed to PRCS to accomodate RM.
- *! 01-Feb-2000 kc: Created.
  */
 
 #include <dspbridge/host_os.h>
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index d3453fa..e758944 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -33,18 +33,6 @@
  *      SYNC_WaitOnEvent
  *      SYNC_WaitOnMultipleEvents
  *
- *! Revision History:
- *! ================
- *! 05-Nov-2001 kc: Minor cosmetic changes.
- *! 05-Oct-2000 jeh Added SYNC_WaitOnMultipleEvents().
- *! 10-Aug-2000 rr: SYNC_PostMessage added.
- *! 10-Jul-2000 jeh Modified SYNC_OpenEvent() to handle NULL attrs.
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 01-Dec-1999 ag: Added optional named event creation in SYNC_OpenEvent().
- *! 22-Nov-1999 kc: Added changes from code review.
- *! 22-Sep-1999 kc: Modified from sync95.c.
- *! 05-Aug-1996 gp: Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/wmd/_cmm.h b/drivers/dsp/bridge/wmd/_cmm.h
index 801b000..d299187 100644
--- a/drivers/dsp/bridge/wmd/_cmm.h
+++ b/drivers/dsp/bridge/wmd/_cmm.h
@@ -27,9 +27,6 @@
  *
  *  Notes:
  *
- *! Revision History:
- *! ================
- *! 24-Aug-2001 ag     Created.
  */
 
 #ifndef _CMM_
diff --git a/drivers/dsp/bridge/wmd/_deh.h b/drivers/dsp/bridge/wmd/_deh.h
index df281ad..81e2906 100644
--- a/drivers/dsp/bridge/wmd/_deh.h
+++ b/drivers/dsp/bridge/wmd/_deh.h
@@ -20,9 +20,6 @@
  *  Description:
  *      Private header for DEH module.
  *
- *! Revision History:
- *! ================
- *! 21-Sep-2001 kc: created.
  */
 
 #ifndef _DEH_
diff --git a/drivers/dsp/bridge/wmd/_msg_sm.h b/drivers/dsp/bridge/wmd/_msg_sm.h
index fa5e9ee..a043cb7 100644
--- a/drivers/dsp/bridge/wmd/_msg_sm.h
+++ b/drivers/dsp/bridge/wmd/_msg_sm.h
@@ -26,10 +26,6 @@
  *
  *  Notes:
  *
- *! Revision History:
- *! ================
- *! 09-May-2001 jeh     Code Review cleanup.
- *! 08-Nov-2000 jeh     Created.
  */
 
 #ifndef _MSG_SM_
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 5267eb2..10fd9cd 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -19,28 +19,6 @@
  *  Description:
  *      Definitions and types private to this WMD.
  *
- *! Revision History
- *! ================
- *! 12-Apr-2004 hp:  Removed the L4 entry of Dsp DMA , not needed
- *! 08-Mar-2004 sb:  Added the Dynamic Memory Mapping feature - PgTableAttrs
- *! 21-Mar-2003 sb:  Added numTLBEntries to struct WMD_DEV_CONTEXT
- *! 20-Feb-2003 vp:  Ported to Linux platform.
- *! 30-Jul-2002 rr:  Modified TBC_ID_VALUE to 0xb47002f.
- *! 10-May-2002 sg:  Added ARM_SYSST_OFFSET and IDLE_DSP_MASK.
- *! 14-Mar-2002 rr:  Added Boot vector field to pDevContext.
- *!                  Added TBC Register defines and value for OMAP1510.
- *! 12-Jan-2002 ag:  wIntrVal2Dsp Added.
- *! 05-Nov-2001 kc:  Added MMU fault related definitions.
- *! 03-Aug-2001 ag   Added TLB table for OEM cofig of DSP-MMU.
- *! 23-Aug-2001 rr:  Added API_SIZE define.
- *! 16-Aug-2001 rr:  Added dwDspExtBaseAddr to access the Ext memory.
- *! 24-Jul-2001 ag:  Added Internal SRAM MMU table entry.
- *! 27-Jun-2001 rr:  Name changed to _tihelen.h.
- *! 27-Jun-2001 ag:  Added dwIntAddr in WMD_DEV_CONTEXT used for MB INTRs msk.
- *! 07-May-2001 ag:  Added DSP Clock Module CLKM2.
- *!                  Added TIHEL_SDRAMPHYSBASE used for DSP MMU init.
- *!                  Added ClearBit() MACRO.
- *! 18-Jan-2001 rr:  Created
  */
 
 #ifndef _TIOMAP_
diff --git a/drivers/dsp/bridge/wmd/_tiomap_mmu.h b/drivers/dsp/bridge/wmd/_tiomap_mmu.h
index 6b21047..c97def5 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_mmu.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_mmu.h
@@ -20,12 +20,6 @@
  *  Description:
  *      Definitions and types for the DSP MMU modules
  *
- *! Revision History
- *! ================
- *! 19-Apr-2004 sb:  Renamed HW types. Removed dspMmuTlbEntry
- *! 05-Jan-2004 vp:  Moved the file to a platform specific folder from common.
- *! 21-Mar-2003 sb:  Added macro definition TIHEL_LARGEPAGESIZE
- *! 08-Oct-2002 rr:  Created.
  */
 
 #ifndef _TIOMAP_MMU_
diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
index 15ff2d3..06d14e4 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
@@ -20,9 +20,6 @@
  *  Description:
  *      Definitions and types for the DSP wake/sleep routines.
  *
- *! Revision History
- *! ================
- *! 08-Oct-2002 rr:  Created.
  */
 
 #ifndef _TIOMAP_PWR_
diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h b/drivers/dsp/bridge/wmd/_tiomap_util.h
index b655409..7d3d765 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_util.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_util.h
@@ -20,9 +20,6 @@
  *  Description:
  *      Definitions and types for the utility routines.
  *
- *! Revision History
- *! ================
- *! 08-Oct-2002 rr:  Created.
  */
 
 #ifndef _TIOMAP_UTIL_
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index e8ffb2f..6a6f7f9 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -58,59 +58,6 @@
  *      and
  *          !LST_Empty(pChnl->pIOCompletions) ==> pChnl->hSyncEvent is set.
  *
- *! Revision History:
- *! ================
- *! 10-Feb-2004 sb: Consolidated the MAILBOX_IRQ macro at the top of the file.
- *! 05-Jan-2004 vp: Updated for 2.6 kernel on 24xx platform.
- *! 23-Apr-2003 sb: Fixed mailbox deadlock
- *! 24-Feb-2003 vp: Code Review Updates.
- *! 18-Oct-2002 vp: Ported to Linux platform
- *! 29-Aug-2002 rr  Changed the SYNC error code return to DSP error code return
- *            in WMD_CHNL_GetIOC.
- *! 22-Jan-2002 ag  Zero-copy support added.
- *!                 CMM_CallocBuf() used for SM allocations.
- *! 04-Feb-2001 ag  DSP-DMA support added.
- *! 22-Nov-2000 kc: Updated usage of PERF_RegisterStat.
- *! 06-Nov-2000 jeh Move ISR_Install, DPC_Create from CHNL_Create to IO_Create.
- *! 13-Oct-2000 jeh Added dwArg parameter to WMD_CHNL_AddIOReq(), added
- *!                 WMD_CHNL_Idle and WMD_CHNL_RegisterNotify for DSPStream.
- *!                 Remove #ifdef DEBUG from around channel cIOCs field.
- *! 21-Sep-2000 rr: PreOMAP chnl class library acts like a IO class library.
- *! 25-Sep-2000 ag: MEM_[Unmap]LinearAddress added for #ifdef CHNL_PREOMAP.
- *! 07-Sep-2000 rr: Added new channel class for PreOMAP.
- *! 11-Jul-2000 jeh Allow NULL user event in WMD_CHNL_Open().
- *! 06-Jul-2000 rr: Changed prefix PROC to PRCS for process module calls.
- *! 20-Jan-2000 ag: Incorporated code review comments.
- *! 05-Jan-2000 ag: Text format cleanup.
- *! 07-Dec-1999 ag: Now setting ChnlMgr fSharedIRQ flag before ISR_Install().
- *! 01-Dec-1999 ag: WMD_CHNL_Open() now accepts named sync event.
- *! 14-Nov-1999 ag: DPC_Schedule() uncommented.
- *! 28-Oct-1999 ag: CHNL Attrs userEvent not supported.
- *!                 SM addrs taken from COFF(IO) or host resource(SM).
- *! 25-May-1999 jg: CHNL_IOCLASS boards now get their shared memory buffer
- *!                 address and length from symbols defined in the currently
- *!                 loaded COFF file. See _chn_sm.h.
- *! 18-Jun-1997 gp: Moved waiting back to ring 0 to improve performance.
- *! 22-Jan-1998 gp: Update User's pIOC struct in GetIOC at lower IRQL (NT).
- *! 16-Jan-1998 gp: Commented out PERF stuff, since it is not all there in NT.
- *! 13-Jan-1998 gp: Protect IOCTLs from IO_DPC by raising IRQL to DIRQL (NT).
- *! 22-Oct-1997 gp: Call SYNC_OpenEvent in CHNL_Open, for NT support.
- *! 18-Jun-1997 gp: Moved waiting back to ring 0 to improve performance.
- *! 16-Jun-1997 gp: Added call into lower edge CHNL function to allow override
- *!                 of the SHM window length reported by Windows CM.
- *! 05-Jun-1997 gp: Removed unnecessary critical sections.
- *! 18-Mar-1997 gp: Ensured CHNL_FlushIO on input leaves channel in READY state.
- *! 06-Jan-1997 gp: ifdefed to support the IO variant of SHM channel class lib.
- *! 21-Jan-1997 gp: CHNL_Close: set pChnl = NULL for DBC_Ensure().
- *! 14-Jan-1997 gp: Updated based on code review feedback.
- *! 03-Jan-1997 gp: Added CHNL_E_WAITTIMEOUT error return code to CHNL_FlushIO()
- *! 23-Oct-1996 gp: Tag channel with ring 0 process handle.
- *! 13-Sep-1996 gp: Added performance statistics for channel.
- *! 09-Sep-1996 gp: Added WMD_CHNL_GetMgrInfo().
- *! 04-Sep-1996 gp: Removed shared memory control struct offset: made zero.
- *! 01-Aug-1996 gp: Implemented basic channel manager and channel create/delete.
- *! 17-Jul-1996 gp: Started pseudo coding.
- *! 11-Jul-1996 gp: Stubbed out.
  */
 
 /*  ----------------------------------- OS */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 037f4f3..7fc4304 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -43,70 +43,6 @@
  *      which may cause timeouts and/or failure of the WIN32_WaitSingleObject
  *      function (SYNC_WaitOnEvent).
  *
- *! Revision History:
- *! ================
- *! 28-Apr-2004 vp: Updated IVA MMU entries based on Aptix validation.
- *! 19-Apr-2004 sb: Clear MBX_DEH_RESET from hIOMgr->wIntrVal to prevent
-		    DEH when MPU invokes DPC before next DSP interrupt.
-		    Revert back GP timer mapping endianness to LE
- *! 22-Apr-2004 sb: Fixed SHM & peripherals endianness settings for 2420
-		    Optimized num. of SHM entries for any SHM size.
- *! 08-Mar-2004 sb: Updated HW_MMU page size macros
- *! 09-Feb-2004 vp: Updated for IVA link driver.
- *! 05-Jan-2004 vp: Updated for the 24xx platform.
- *! 23-Apr-2003 sb: Fixed mailbox deadlock
- *! 13-Apr-2003 vp: Updated to support TC Word Swap option.
- *! 21-Mar-2003 sb: OEM configuration updates
- *! 24-Feb-2003 vp: Code Review Updates.
- *! 18-Oct-2002 sb: Ported to Linux platform
- *! 28-Mar-2002 jeh Assume word addresses for SHM, MSG, ... symbol values.
- *! 25-Jan-2002 ag  bDspAck incorrectly set in IO_DDZCDispatchChnl()
- *! 05-Jan-2002 ag  Set MBX value to DSP using IO_InterruptDSP2().
- *!		 Check for CHNL_STATECANCEL in ACK processing.
- *! 20-Dec-2001 ag  Removed #ifdef CHNL_NOIPCINTR & CHNL_PREOMAP for DSP-DMA.
- *!		 Removed unused fxn GetDDMAChnl().
- *! 11-Dec-2001 ag  Fix in DDMA_Dispatch for multi-bufs.
- *! 06-Nov-2001 ag  DSP-DMA I/O processing support added.
- *! 05-Nov-2001 kc  Updated to support DEH module.
- *! 18-Sep-2001 ag  Using virtual cached addressing for SM.
- *! 29-Aug-2001 ag  User SM regions registered during prog load.
- *! 10-Aug-2001 ag  Removed dependency on platform\inc\Config.h.
- *!		 MMU setup OnLoaded & per DEV context.
- *! 08-May-2001 ag  Don't SwapWord if TIHELEN.
- *! 31-May-2001 ag  Fixed bug in pInput calc.
- *! 21-May-2001 ag  Helen SM uses TICFG_BRIDGE_DATA_BASE[SIZE] in Config.h.
- *! 04-May-2001 jeh Replaced CHNL_PREOMAP with CHNL_OMAP, added CHNL_HELEN.
- *!		 Cleaned up WMD_IO_OnLoaded a bit.
- *! 10-Apr-2001 rr: Replaced DBG_ENTER with DBG_LEVEL3.
- *! 28-Mar-2001 ag  Added CHNL_NOIPCINTR. Disables IPC INTR handling.
- *! 16-Feb-2001 jeh Messaging disabled for PREOMAP.
- *! 16-Dec-2000 ag  IO_DispatchMsg() enabled for PreOMAP.
- *!		 SM must be in last 4 Meg region SDRAM for PreOMAP.
- *! 14-Dec-2000 jeh Now reads SM addresses from COFF for PreOMAP.
- *! 04-Dec-2000 jeh Bug fixes for messaging.
- *! 20-Nov-2000 jeh Updated to handle messaging.
- *! 23-Oct-2000 jeh Added notifications of IO complete and end of stream for
- *!		 DSPStream support. Pass arg in SHM structure.
- *! 07-Jul-2000 rr: Changed Prefix proc to prcs for Process module.
- *! 03-Feb-2000 rr: DBG statements during fxn entry added.
- *! 21-Jan-2000 ag: Clean-up per code review.
- *! 10-Dev-1999 ag: Added critical section in IO_Dispatch() to protect IOCL/IOR.
- *!		 Removed DBC_Asserts after cancelled/closed channels.
- *!		 Replaced x86 specific __asm int 3 with DBC_Assert(false);
- *! 12-Nov-1999 ag: Removed some warnings when compiling for 16 bit targets.
- *!		 (See #if _CHNL_WORDSIZE).
- *! 04-Nov-1999 ag: WinCE port.
- *! 25-May-1999 jg: Test that CHNL_IOCLASS boards have a loaded program with
- *!		 a defined shared memory buffer.
- *! 09-Jul-1997 gp: Added some checks for validity of SHM control block values.
- *! 17-Jan-1997 db: Added capability to log shared memory header.
- *! 15-Jan-1997 gp: Code Review mods: moved static dwLastId to CHNL_MGR object.
- *! 03-Jan-1997 gp: Added call to CHNLSM_DPC from IO_DPC. Check for ISR failing
- *!		 to process interrupt on a non-shared IRQ line.
- *! 10-Dec-1996 gp: Added EOS notification on input channel (CHNL_MODEFROMDSP).
- *! 27-Nov-1996 gp: Fixed bug in IO_Dispatch(), which fixed flushing.
- *! 23-Oct-1996 gp: Ensure client buffer bounds are not overrun on input.
- *! 12-Aug-1996 gp: Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 5585cdb..666d08b 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -19,16 +19,6 @@
  *  Description:
  *      Implements DSP MMU fault handling functions.
  *
- *! Revision History:
- *! ================
- *! 26-Dec-2004 hn: Support for IVA MMU exception.
- *! 06-Mar-2003 sb: Print MMU fault address. Cosmetic changes.
- *! 16-Feb-2003 vp: Fixed warning in MMU_FaultIsr
- *! 05-Jan-2004 vp: Updated support for 24xx silicon
- *! 19-Feb-2003 vp: Code review updates.
- *!                 - Cosmetic changes.
- *! 18-Oct-2002 sb: Ported to Linux platform.
- *! 10-Sep-2001 kc: created.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.h b/drivers/dsp/bridge/wmd/mmu_fault.h
index be59333..eeb4c6f 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.h
+++ b/drivers/dsp/bridge/wmd/mmu_fault.h
@@ -20,10 +20,6 @@
  *  Description:
  *      Defines DSP MMU fault handling functions.
  *
- *! Revision History:
- *! ================
- *! 26-Dec-2004 hn: IVA MMU handlers.
- *! 10-Sep-2001 kc: created.
  */
 
 #ifndef MMU_FAULT_
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 19fa135..379278c 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -30,16 +30,6 @@
  *      WMD_MSG_RegisterNotify
  *      WMD_MSG_SetQueueId
  *
- *! Revision History:
- *! =================
- *! 24-Jul-2002 jeh     Release critical section in WMD_MSG_Put() before
- *!                     scheduling DPC.
- *! 09-May-2001 jeh     Free MSG queue NTFY object, remove unnecessary set/
- *!                     reset of events.
- *! 10-Jan-2001 jeh     Set/Reset message manager and message queue events
- *!                     correctly.
- *! 04-Dec-2000 jeh     Bug fixes.
- *! 12-Sep-2000 jeh     Created.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a6e695a..d7e005a 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -22,9 +22,6 @@
  *  Public Function:
  *      WMD_DRV_Entry
  *
- *! Revision History:
- *! ================
- *   26-March-2008 HK and AL:  Added WMD_DEV_WalkTbl funciton.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index f3e7645..991a669 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -19,14 +19,6 @@
  *  Description:
  *      Implementation of DSP wake/sleep routines.
  *
- *! Revision History
- *! ================
- *! 01-Nov-2007 HK: Added Off mode(Hibernation) support and DVFS support
- *! 05-Jan-2004 vp: Moved the file to platform specific folder and commented the
- *!		    code.
- *! 27-Mar-2003 vp: Added support for DSP boot idle mode.
- *! 06-Dec-2002 cring:  Added Palm support.
- *! 08-Oct-2002 rr:  Created.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 6121e8f..e59350b 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -20,13 +20,6 @@
  *  Description:
  *      Implementation for the io read/write routines.
  *
- *! Revision History
- *! ================
- *! 16-Feb-2004 vp:  Fixed warning in WriteDspData function.
- *! 16-Apr-2003 vp:  Added support for TC word swap
- *! 26-Feb-2003 vp:  Fixed issue with EXT_BEG and EXT_END address.
- *! 24-Feb-2003 vp:  Ported to Linux platform
- *! 08-Oct-2002 rr:  Created.
  */
 
 /*  ----------------------------------- DSP/BIOS Bridge */
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.h b/drivers/dsp/bridge/wmd/tiomap_io.h
index 84a7553..ee29fc6 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.h
+++ b/drivers/dsp/bridge/wmd/tiomap_io.h
@@ -21,9 +21,6 @@
  *      Definitions, types and function prototypes for the io
  *      (r/w external mem).
  *
- *! Revision History
- *! ================
- *! 08-Oct-2002 rr:  Created.
  */
 
 #ifndef _TIOMAP_IO_
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 9bc5b54..6e258f4 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -19,21 +19,6 @@
  *  Description:
  *      Implements lower edge channel class library functions.
  *
- *! Revision History:
- *! ================
- *! 05-Jan-2004 vp    Updated for the new HW library for 24xx platform.
- *! 12-Feb-2004 hp    use 'CFG_GetHostResources' to fetch virtual addresses of
- *!           PRCM, dMMU components.
- *! 08-Oct-2002 rr    Renamed to tiomap1510_sm.c
- *! 15-Feb-2002 ag    Remove #include <pkfuncs.h> & util.h.
- *! 07-Jan-2001 ag    Set DSP MBX val (to DSP) contained in DEV context.
- *! 05-Nov-2001 kc:   Modified CHNLSM_ISR to read mailbox1 interrupt values
- *! 26-Sep-2001 rr:   InterruptDSP does not spin forever for retail build.
- *! 29-Aug-2001 rr:   Cleaned up the non referenced variables.
- *! 26-Jul-2001 jeh   Enable interrupt to DSP.
- *! 28-Jun-2001 ag    Disable INTR gen to DSP in CHNLSM_InterruptDSP().
- *! 26-Jun-2001 ag    Added INTR support.
- *! 17-May-2000 ag    Initial. No INTR support.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index d5551cb..4f28cca 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -20,15 +20,6 @@
  *  Description:
  *      Implements upper edge DSP exception handling (DEH) functions.
  *
- *! Revision History:
- *! ================
- *! 03-Jan-2005 hn: Support for IVA DEH.
- *! 05-Jan-2004 vp: Updated for the 24xx HW library.
- *! 19-Feb-2003 vp: Code review updates.
- *!                 - Cosmetic changes.
- *! 18-Oct-2002 sb: Ported to Linux platform.
- *! 10-Dec-2001 kc: Updated DSP error reporting in DEBUG mode.
- *! 10-Sep-2001 kc: created.
  */
 
 /*  ----------------------------------- Host OS */
-- 
1.6.2.313.g33352

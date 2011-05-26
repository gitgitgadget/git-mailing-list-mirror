From: Osamu OKANO <okano.osamu@gmail.com>
Subject: Using Zenburn color scheme in gitk
Date: Thu, 26 May 2011 22:25:11 +0900
Message-ID: <BANLkTinnHgdHSasU2EtxLns-7Nb5wR0WYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 15:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPaZ5-0001jD-BL
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 15:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab1EZNZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 09:25:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53834 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab1EZNZM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 09:25:12 -0400
Received: by iwn34 with SMTP id 34so571109iwn.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=iEVCiIJKOcrJBHdMjfEjmEEl7QveKPUxnTPit4KeYtY=;
        b=lpIlOGxrR/gmSf6MHbVIx7CZdnmvSFEb1F9nbvrUtx+gGWDgdRgIMziH4Meue38PIW
         yxFhE5ovSVC3oMEP9WJTnUste/9fhmXDJxeIk0kFh9P4wuMR6ba7bZeoX2KGEP+E4aW5
         zVyPkWBvfHNjT5LE2/LlD3lR56k2+1/C/cDk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HLViJ6yHL73R9B3LWayI6GuRiPJ1/nmm56GOSfZHE+eNcmjwFCqdEJsCPC+92FAutX
         jOEXN8eMSiIHINZoEq6nlZXNSxzD4T9m4fWIJmmZ9Kzv4VRfygxPICTTWlUXSpaK1WoY
         l26jsGDhRR6/63NQ2XEZdyOBRsbkgcVbjbFPg=
Received: by 10.42.133.69 with SMTP id g5mr1055593ict.289.1306416311621; Thu,
 26 May 2011 06:25:11 -0700 (PDT)
Received: by 10.42.167.199 with HTTP; Thu, 26 May 2011 06:25:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174506>

I like Zenburn color scheme.
I use it on Emacs, chrome, mintty.
So I tried to use Zenburn in gitk.

screenshot is http://bit.ly/j6jmv0
Regards.
=== ~/.gitk ===
set bgcolor #3f3f3f
set fgcolor #dcdccc
set colors {#7f9f7f #cc9393 #8cd0d3 #dc8cc3 darkgrey brown #dfaf8f}
set diffcolors {"#705050" "#60b48a" "#8cd0d3"}
set markbgcolor #e0e0ff
set selectbgcolor #506070
===
diff --git a/gitk b/gitk
index 4cde0c4..06077af 100755
--- a/gitk
+++ b/gitk
@@ -2164,9 +2164,9 @@ proc makewindow {} {
 	set h [expr {[font metrics uifont -linespace] + 2}]
 	set progresscanv .tf.bar.progress
 	canvas $progresscanv -relief sunken -height $h -borderwidth 2
-	set progressitem [$progresscanv create rect -1 0 0 $h -fill green]
-	set fprogitem [$progresscanv create rect -1 0 0 $h -fill yellow]
-	set rprogitem [$progresscanv create rect -1 0 0 $h -fill red]
+	set progressitem [$progresscanv create rect -1 0 0 $h -fill #7f9f7f]
+	set fprogitem [$progresscanv create rect -1 0 0 $h -fill #f0dfaf]
+	set rprogitem [$progresscanv create rect -1 0 0 $h -fill #cc9393]
     }
     pack $progresscanv -side right -expand 1 -fill x -padx {0 2}
     set progresscoords {0 0}
@@ -2295,9 +2295,9 @@ proc makewindow {} {
     $ctext tag conf hunksep -fore [lindex $diffcolors 2]
     $ctext tag conf d0 -fore [lindex $diffcolors 0]
     $ctext tag conf dresult -fore [lindex $diffcolors 1]
-    $ctext tag conf m0 -fore red
-    $ctext tag conf m1 -fore blue
-    $ctext tag conf m2 -fore green
+    $ctext tag conf m0 -fore "#cc9393"
+    $ctext tag conf m1 -fore "#8cd0d3"
+    $ctext tag conf m2 -fore "#7f9f7f"
     $ctext tag conf m3 -fore purple
     $ctext tag conf m4 -fore brown
     $ctext tag conf m5 -fore "#009090"
@@ -2315,7 +2315,7 @@ proc makewindow {} {
     set mergemax 16
     $ctext tag conf mresult -font textfontbold
     $ctext tag conf msep -font textfontbold
-    $ctext tag conf found -back yellow
+    $ctext tag conf found -back "#f0dfaf"

     .pwbottom add .bleft
     if {!$use_ttk} {
@@ -3150,7 +3150,7 @@ image create bitmap tri-dn -background black
-foreground blue -data {
        0x00, 0x00};
 }

-image create bitmap reficon-T -background black -foreground yellow -data {
+image create bitmap reficon-T -background black -foreground #f0dfaf -data {
     #define tagicon_width 13
     #define tagicon_height 9
     static unsigned char tagicon_bits[] = {
@@ -3177,7 +3177,7 @@ set rectmask {
        0x00, 0x00, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f,
        0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0x00, 0x00};
 }
-image create bitmap reficon-H -background black -foreground green \
+image create bitmap reficon-H -background black -foreground #7f9f7f \
     -data $rectdata -maskdata $rectmask
 image create bitmap reficon-o -background black -foreground "#ddddff" \
     -data $rectdata -maskdata $rectmask
@@ -5850,9 +5850,9 @@ proc drawcmittext {id row col} {
     if {$id eq $nullid} {
 	set ofill red
     } elseif {$id eq $nullid2} {
-	set ofill green
+	set ofill #7f9f7f
     } elseif {$id eq $mainheadid} {
-	set ofill yellow
+	set ofill #f0dfaf
     } else {
 	set ofill [lindex $circlecolors $listed]
     }
@@ -6309,13 +6309,13 @@ proc drawtags {id x xt y1} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-		       -width 1 -outline black -fill yellow -tags tag.$id]
+		       -width 1 -outline #3f3f3f -fill #f0dfaf -tags tag.$id]
 	    $canv bind $t <1> [list showtag $tag_quoted 1]
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
 	    # draw a head or other ref
 	    if {[incr nheads -1] >= 0} {
-		set col green
+		set col #7f9f7f
 		if {$tag eq $mainhead} {
 		    set font mainfontbold
 		}
@@ -6324,7 +6324,7 @@ proc drawtags {id x xt y1} {
 	    }
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
-		-width 1 -outline black -fill $col -tags tag.$id
+		-width 1 -outline #3f3f3f -fill $col -tags tag.$id
 	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
@@ -6334,7 +6334,7 @@ proc drawtags {id x xt y1} {
 			-width 0 -fill "#ffddaa" -tags tag.$id
 	    }
 	}
-	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $fgcolor \
+	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $bgcolor \
 		   -font $font -tags [list tag.$id text]]
 	if {$ntags >= 0} {
 	    $canv bind $t <1> [list showtag $tag_quoted 1]
@@ -6633,7 +6633,7 @@ proc markmatches {canv l str tag matches font row} {
 	set xlen [font measure $font [string range $str 0 [expr {$end}]]]
 	set t [$canv create rect [expr {$x0+$xoff}] $y0 \
 		   [expr {$x0+$xlen+2}] $y1 \
-		   -outline {} -tags [list match$l matches] -fill yellow]
+		   -outline {} -tags [list match$l matches] -fill #f0dfaf]
 	$canv lower $t
 	if {$row == $selectedline} {
 	    $canv raise $t secsel
@@ -6716,7 +6716,7 @@ proc setlink {id lk} {
 	set known [commitinview $id $curview]
     }
     if {$known} {
-	$ctext tag conf $lk -foreground blue -underline 1
+	$ctext tag conf $lk -foreground #8cd0d3 -underline 1
 	$ctext tag bind $lk <1> [list selbyid $id]
 	$ctext tag bind $lk <Enter> {linkcursor %W 1}
 	$ctext tag bind $lk <Leave> {linkcursor %W -1}
@@ -8846,7 +8846,7 @@ proc redrawtags {id} {
     if {![info exists iddrawn($id)]} return
     set row [rowofcommit $id]
     if {$id eq $mainheadid} {
-	set ofill yellow
+	set ofill #f0dfaf
     } else {
 	set ofill [lindex $circlecolors $cmitlisted($curview,$id)]
     }
@@ -11459,7 +11459,7 @@ set ignorespace 0
 set worddiff ""
 set markbgcolor "#e0e0ff"

-set circlecolors {white blue gray blue blue}
+set circlecolors {"#DCDCCC" "#8cd0d3" "#999999" "#8cd0d3" "#8cd0d3"}

 # button for popping up context menus
 if {[tk windowingsystem] eq "aqua"} {

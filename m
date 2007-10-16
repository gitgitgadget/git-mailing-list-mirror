From: "Dave Korn" <dave.korn@artimi.com>
Subject: RE: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 16:47:31 +0100
Message-ID: <03e101c8100b$de7fa0d0$2e08a8c0@CAM.ARTIMI.COM>
References: <1192293466.17584.95.camel@homebase.localnet><uy7e6keyv.fsf@gnu.org><1192381040.4908.57.camel@homebase.localnet><1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr><47125F74.9050600@op5.se><Pine.LNX.4.64.0710141934310.25221@racer.site><47126957.1020204@op5.se><Pine.LNX.4.64.0710142112540.25221@racer.site><20071014221446.GC2776@steel.home>
	<u7ilpjp3x.fsf@gnu.org><Pine.LNX.4.64.0710151859590.7638@iabervon.org><uodezisvg.fsf@gnu.org>
	<471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_03E2_01C81014.404408D0"
Cc: git@vger.kernel.org, barkalow@iabervon.org, raa.lkml@gmail.com,
	make-w32@gnu.org, Johannes.Schindelin@gmx.de
To: "'Eli Zaretskii'" <eliz@gnu.org>,
	"'Andreas Ericsson'" <ae@op5.se>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Tue Oct 16 17:48:00 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhoeB-0007w4-6M
	for gnu-make-w32@m.gmane.org; Tue, 16 Oct 2007 17:47:55 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1Ihoe2-0000oU-Mp
	for gnu-make-w32@m.gmane.org; Tue, 16 Oct 2007 11:47:46 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Ihody-0000oD-9V
	for make-w32@gnu.org; Tue, 16 Oct 2007 11:47:42 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Ihodw-0000nh-L0
	for make-w32@gnu.org; Tue, 16 Oct 2007 11:47:42 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Ihodw-0000ne-Fj
	for make-w32@gnu.org; Tue, 16 Oct 2007 11:47:40 -0400
Received: from mail.artimi.com ([194.72.81.2])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dave.korn@artimi.com>)
	id 1Ihods-0001Of-Fx; Tue, 16 Oct 2007 11:47:36 -0400
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft
	SMTPSVC(6.0.3790.3959); Tue, 16 Oct 2007 16:47:31 +0100
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcgPvVnOJHuvteYkRIu4Ji3H3IqTAAARfc3w
X-OriginalArrivalTime: 16 Oct 2007 15:47:34.0194 (UTC)
	FILETIME=[DE658920:01C8100B]
X-detected-kernel: by monty-python.gnu.org: Windows 2000 SP4, XP SP1+
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61198>

This is a multi-part message in MIME format.

------=_NextPart_000_03E2_01C81014.404408D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On 16 October 2007 07:25, Eli Zaretskii wrote:

> On the other hand, what packages have 100K files?  If there's only one
> -- the Linux kernel -- then I think this kind of performance is for
> all practical purposes unimportant on Windows, because while it is
> reasonable to assume that someone would like to use git on Windows,
> assuming that someone will develop the Linux kernel on Windows is --
> how should I put it -- _really_ far-fetched ;-)

  Hi there!  Did someone call?

  Cross-development in general isn't what I'd call "far-fetched", and there's
no law of cross-development that says the host has to be the same platform as
the target.  :-)[*]

    cheers,
      DaveK

[*] - this smiley sponsored by the Department of the Bleedin' Obvious.
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_03E2_01C81014.404408D0
Content-Type: application/octet-stream;
	name="developed-on-windows.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="developed-on-windows.diff"

Index: firmware_class.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: =
/sources/repository/external_source/linux/linux-2.6.12.2/drivers/base/fir=
mware_class.c,v=0A=
retrieving revision 1.1=0A=
retrieving revision 1.2=0A=
diff -p -u -r1.1 -r1.2=0A=
--- firmware_class.c	17 Jan 2006 16:49:35 -0000	1.1=0A=
+++ firmware_class.c	15 Feb 2006 14:01:29 -0000	1.2=0A=
@@ -31,6 +31,7 @@ enum {=0A=
 };=0A=
 =0A=
 static int loading_timeout =3D 10;	/* In seconds */=0A=
+static char grow_faster =3D 1;      /* Boolean */=0A=
 =0A=
 /* fw_lock could be moved to 'struct firmware_priv' but since it is just=0A=
  * guarding for corner cases a global lock should be OK */=0A=
@@ -79,6 +80,28 @@ firmware_timeout_store(struct class *cla=0A=
 =0A=
 static CLASS_ATTR(timeout, 0644, firmware_timeout_show, =
firmware_timeout_store);=0A=
 =0A=
+static ssize_t=0A=
+firmware_grow_faster_show(struct class *class, char *buf)=0A=
+{=0A=
+	return sprintf(buf, "%d\n", grow_faster);=0A=
+}=0A=
+=0A=
+/**=0A=
+ * firmware_grow_faster_store:=0A=
+ * Description:=0A=
+ *	Sets or clears a flag that causes the reallocate routine to=0A=
+ *	grow the firmware buffer size more or less quickly.=0A=
+ *  =0A=
+ **/=0A=
+static ssize_t=0A=
+firmware_grow_faster_store(struct class *class, const char *buf, size_t =
count)=0A=
+{=0A=
+	grow_faster =3D simple_strtol(buf, NULL, 10) !=3D 0;=0A=
+	return count;=0A=
+}=0A=
+=0A=
+static CLASS_ATTR(grow_faster, 0644, firmware_grow_faster_show, =
firmware_grow_faster_store);=0A=
+=0A=
 static void  fw_class_dev_release(struct class_device *class_dev);=0A=
 int firmware_class_hotplug(struct class_device *dev, char **envp,=0A=
 			   int num_envp, char *buffer, int buffer_size);=0A=
@@ -198,18 +221,27 @@ static int=0A=
 fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)=0A=
 {=0A=
 	u8 *new_data;=0A=
+  int new_size;=0A=
 =0A=
 	if (min_size <=3D fw_priv->alloc_size)=0A=
 		return 0;=0A=
 =0A=
-	new_data =3D vmalloc(fw_priv->alloc_size + PAGE_SIZE);=0A=
+#define ONE_MEG (1024 * 1024)=0A=
+=0A=
+  new_size =3D grow_faster =0A=
+    ? ((fw_priv->alloc_size >=3D ONE_MEG)=0A=
+      ? (fw_priv->alloc_size + ONE_MEG)=0A=
+      : ((fw_priv->alloc_size >=3D PAGE_SIZE) ? (fw_priv->alloc_size * =
2) : PAGE_SIZE))=0A=
+    : (fw_priv->alloc_size + PAGE_SIZE);=0A=
+  new_data =3D vmalloc (new_size);=0A=
 	if (!new_data) {=0A=
-		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);=0A=
+		printk(KERN_ERR "%s: unable to alloc buffer old size %d new size =
%d\n",=0A=
+      __FUNCTION__, fw_priv->alloc_size, new_size);=0A=
 		/* Make sure that we don't keep incomplete data */=0A=
 		fw_load_abort(fw_priv);=0A=
 		return -ENOMEM;=0A=
 	}=0A=
-	fw_priv->alloc_size +=3D PAGE_SIZE;=0A=
+  fw_priv->alloc_size =3D new_size;=0A=
 	if (fw_priv->fw->data) {=0A=
 		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);=0A=
 		vfree(fw_priv->fw->data);=0A=
@@ -249,6 +281,13 @@ firmware_data_write(struct kobject *kobj=0A=
 		goto out;=0A=
 =0A=
 	memcpy(fw->data + offset, buffer, count);=0A=
+  /*  A successful write should cause us to reset the timeout=0A=
+  delay, as very large firmware files might take a while to=0A=
+  send through the sysfs file.  We have the fw_lock taken at=0A=
+  the moment but the timeout function doesn't lock as it only=0A=
+  has to set a single volatile bit, so we're ok to mod it. */=0A=
+  if (timer_pending (&fw_priv->timeout))=0A=
+    mod_timer (&fw_priv->timeout, jiffies + loading_timeout * HZ);=0A=
 =0A=
 	fw->size =3D max_t(size_t, offset + count, fw->size);=0A=
 	retval =3D count;=0A=
@@ -568,6 +607,12 @@ firmware_class_init(void)=0A=
 		       __FUNCTION__);=0A=
 		class_unregister(&firmware_class);=0A=
 	}=0A=
+	error =3D class_create_file(&firmware_class, &class_attr_grow_faster);=0A=
+	if (error) {=0A=
+		printk(KERN_ERR "%s: class_create_file failed\n",=0A=
+		       __FUNCTION__);=0A=
+		class_unregister(&firmware_class);=0A=
+	}=0A=
 	return error;=0A=
 =0A=
 }=0A=

------=_NextPart_000_03E2_01C81014.404408D0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Make-w32 mailing list
Make-w32@gnu.org
http://lists.gnu.org/mailman/listinfo/make-w32

------=_NextPart_000_03E2_01C81014.404408D0--

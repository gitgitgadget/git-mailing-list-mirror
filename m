From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH 2/2] add csharp userdiff tests
Date: Sun, 27 Apr 2014 16:47:01 +0300
Message-ID: <3A0D05C9-C222-463E-BCD4-CD38F216E352@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 15:46:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WePPE-0000yS-8x
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 15:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbaD0NqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 09:46:04 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:62300 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaD0NqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 09:46:03 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so4045838eek.40
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Day3WhuhsOlOwBI6bASkPWaAi5SOAR+Tu5c9SFmKAM=;
        b=B+NfEAvndkbNGAqljBImbDjzOjBIth/MEheWt6tC4G2R3863NU5TnuukJABGZXd+Xb
         otfDYDK8OuaMHWAVXZVhca0HqqXFuJ8HEYWlYPEzp1pst3NWxqd47zk8NXmIui8O3mCo
         7q0YekRzWGm2pjbiKEgK7SYLruXN7M4YobZAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=7Day3WhuhsOlOwBI6bASkPWaAi5SOAR+Tu5c9SFmKAM=;
        b=GiQqW8udFRZ+k+/jGZXaGJlzRS9jMoF5rVwLkROCmbJUZruSAEFBVRWOOUtv8XDE/3
         iUajncjQ5oAbifqcEYScSjyDC86fNV38PZbT2/fIxGRl819sR6m5IgS/RG8xltjYF0AQ
         hwhcA5Zz2lcMyDFMDdiyaxDUoqDncWoW/cbLrXBfFnbPx7+Bbupcdswd24+liABNpoNv
         zXFtLCuh76RFGiyGPokZFaJ3pQQh5JsQxfgVezbXb0qQg9nWBlXMqbLAXYMrf/RfSl/r
         cYQKYJX6tg86MD8D56ra7KIxkWxG35HbGBZEmdjwIaj0B22qs9tKdUqveEEmsPK6WqBX
         9C5A==
X-Gm-Message-State: ALoCoQkxsIANYcM21vk2yspMrg17xcfhcncRk4CfLAKf2aH9Ggj35I7p7jpLQRYoyYtZN4hSo76L
X-Received: by 10.14.126.73 with SMTP id a49mr25408238eei.46.1398606360777;
        Sun, 27 Apr 2014 06:46:00 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id e42sm41818704eev.32.2014.04.27.06.45.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 06:46:00 -0700 (PDT)
In-Reply-To: <535BFFEB.8040103@kdbg.org>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247202>


---
 t/t4018/csharp-constructor | 4 ++++
 t/t4018/csharp-destructor  | 4 ++++
 t/t4018/csharp-function    | 4 ++++
 t/t4018/csharp-member      | 4 ++++
 t/t4018/csharp-namespace   | 4 ++++
 t/t4018/csharp-operator    | 4 ++++
 t/t4018/csharp-property    | 4 ++++
 t/t4018/csharp-skip-call   | 5 +++++
 8 files changed, 33 insertions(+)
 create mode 100644 t/t4018/csharp-constructor
 create mode 100644 t/t4018/csharp-destructor
 create mode 100644 t/t4018/csharp-function
 create mode 100644 t/t4018/csharp-member
 create mode 100644 t/t4018/csharp-namespace
 create mode 100644 t/t4018/csharp-operator
 create mode 100644 t/t4018/csharp-property
 create mode 100644 t/t4018/csharp-skip-call

diff --git a/t/t4018/csharp-constructor b/t/t4018/csharp-constructor
new file mode 100644
index 0000000..a39cffb
--- /dev/null
+++ b/t/t4018/csharp-constructor
@@ -0,0 +1,4 @@
+MyClass(RIGHT)
+{
+	ChangeMe;
+}
diff --git a/t/t4018/csharp-destructor b/t/t4018/csharp-destructor
new file mode 100644
index 0000000..55106d9
--- /dev/null
+++ b/t/t4018/csharp-destructor
@@ -0,0 +1,4 @@
+~MyClass(RIGHT)
+{
+	ChangeMe;
+}
diff --git a/t/t4018/csharp-function b/t/t4018/csharp-function
new file mode 100644
index 0000000..a5d59a3
--- /dev/null
+++ b/t/t4018/csharp-function
@@ -0,0 +1,4 @@
+virtual DoStuff(RIGHT)
+{
+	ChangeMe;
+}
diff --git a/t/t4018/csharp-member b/t/t4018/csharp-member
new file mode 100644
index 0000000..4939d53
--- /dev/null
+++ b/t/t4018/csharp-member
@@ -0,0 +1,4 @@
+unsafe class RIGHT
+{
+	int ChangeMe;
+}
diff --git a/t/t4018/csharp-namespace b/t/t4018/csharp-namespace
new file mode 100644
index 0000000..6749980
--- /dev/null
+++ b/t/t4018/csharp-namespace
@@ -0,0 +1,4 @@
+namespace RIGHT
+{
+	ChangeMe;
+}
diff --git a/t/t4018/csharp-operator b/t/t4018/csharp-operator
new file mode 100644
index 0000000..5b00263
--- /dev/null
+++ b/t/t4018/csharp-operator
@@ -0,0 +1,4 @@
+A operator+(RIGHT)
+{
+	ChangeMe;
+}
diff --git a/t/t4018/csharp-property b/t/t4018/csharp-property
new file mode 100644
index 0000000..82d67fc
--- /dev/null
+++ b/t/t4018/csharp-property
@@ -0,0 +1,4 @@
+public virtual int RIGHT
+{
+	get { ChangeMe; }
+}
diff --git a/t/t4018/csharp-skip-call b/t/t4018/csharp-skip-call
new file mode 100644
index 0000000..e89d083
--- /dev/null
+++ b/t/t4018/csharp-skip-call
@@ -0,0 +1,5 @@
+virtual void RIGHT()
+{
+	call();
+	ChangeMe;
+}
-- 
1.8.4

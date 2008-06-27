From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 23/23] Use new TransportException constructors
Date: Sat, 28 Jun 2008 00:06:47 +0200
Message-ID: <1214604407-30572-24-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-15-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-16-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-17-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-18-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-19-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-20-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-21-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-22-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-23-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM9A-0001Lw-V8
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761255AbYF0WIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761264AbYF0WIs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:34645 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761125AbYF0WIo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so330267fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lfCG8RzC4jIBTQHy7JO+EORvlVAUNKX6HNbdOi52eNs=;
        b=vxSdOn8ph81nWRB5SBIem0YaDtAC3zvO7EfCIVH/6tz+TMz9Yl6hSPQLS52WFdXje3
         pzaZMubgLawxw2V4YIPwbpya4fQ1fTz3m5qEbotw08q+e5j37uBpSm/7BndxBKFO0YH0
         qT1MnT5nnE73Jud90xkaUPX/JAzptTIfiCIPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SdBx9vLKFtc1cEjVD0/ZwWocuBtaPZQyWjB9jkf2DGZw46t7gdIrs6xUSeJ/BSZSMV
         Ilaj95nqg84ExpmeiEFVK2C804QK/dVnvM4V1V4HUBQHLqLSTkKwkSAiAQwEn8uN4IG6
         hmh98c7d0Ymcm/3dP+K8dXf4h2ZPCtO7cxxo4=
Received: by 10.86.52.6 with SMTP id z6mr2535733fgz.18.1214604519965;
        Fri, 27 Jun 2008 15:08:39 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l19sm3760309fgb.7.2008.06.27.15.08.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:38 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-23-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86661>

Modify existing TransportException constructor calls to new ones with
URI as argument.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/BasePackConnection.java |    6 +++---
 .../jgit/transport/BasePackPushConnection.java     |   12 ++++++------
 .../org/spearce/jgit/transport/PushProcess.java    |    6 +++---
 .../spearce/jgit/transport/TransportGitAnon.java   |   15 +++++++--------
 .../spearce/jgit/transport/TransportGitSsh.java    |   18 ++++++++----------
 .../org/spearce/jgit/transport/TransportLocal.java |    3 +--
 .../org/spearce/jgit/transport/TransportSftp.java  |   12 +++++-------
 7 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index d119672..9b39ebc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -125,7 +125,7 @@ abstract class BasePackConnection extends BaseConnection {
 				line = pckIn.readString();
 			} catch (EOFException eof) {
 				if (avail.isEmpty())
-					throw new TransportException(uri + " not found.");
+					throw new TransportException(uri, "not found.");
 				throw eof;
 			}
 
@@ -155,7 +155,7 @@ abstract class BasePackConnection extends BaseConnection {
 				name = name.substring(0, name.length() - 3);
 				final Ref prior = avail.get(name);
 				if (prior == null)
-					throw new PackProtocolException(uri + ": advertisement of "
+					throw new PackProtocolException(uri, "advertisement of "
 							+ name + "^{} came before " + name);
 
 				if (prior.getPeeledObjectId() != null)
@@ -185,7 +185,7 @@ abstract class BasePackConnection extends BaseConnection {
 	}
 
 	private PackProtocolException duplicateAdvertisement(final String name) {
-		return new PackProtocolException(uri + ": duplicate advertisements of "
+		return new PackProtocolException(uri, "duplicate advertisements of "
 				+ name);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 159e331..c56605a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -110,7 +110,7 @@ class BasePackPushConnection extends BasePackConnection implements
 		} catch (TransportException e) {
 			throw e;
 		} catch (Exception e) {
-			throw new TransportException(uri + ": " + e.getMessage(), e);
+			throw new TransportException(uri, e.getMessage(), e);
 		} finally {
 			close();
 		}
@@ -146,7 +146,7 @@ class BasePackPushConnection extends BasePackConnection implements
 		}
 
 		if (monitor.isCancelled())
-			throw new TransportException(uri + ": push cancelled");
+			throw new TransportException(uri, "push cancelled");
 		pckOut.end();
 	}
 
@@ -179,13 +179,13 @@ class BasePackPushConnection extends BasePackConnection implements
 			throws IOException {
 		final String unpackLine = pckIn.readString();
 		if (!unpackLine.startsWith("unpack "))
-			throw new PackProtocolException(uri + ": unexpected report line: "
+			throw new PackProtocolException(uri, "unexpected report line: "
 					+ unpackLine);
 		final String unpackStatus = unpackLine.substring("unpack ".length());
 		if (!unpackStatus.equals("ok"))
-			throw new TransportException(uri
-					+ ": error occurred during unpacking on the remote end: "
-					+ unpackStatus);
+			throw new TransportException(uri,
+					"error occurred during unpacking on the remote end: "
+							+ unpackStatus);
 
 		String refLine;
 		while ((refLine = pckIn.readString()).length() > 0) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
index f742949..1b5f9c6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
@@ -178,9 +178,9 @@ class PushProcess {
 			} catch (MissingObjectException x) {
 				fastForward = false;
 			} catch (Exception x) {
-				throw new TransportException(transport.getURI()
-						+ ": reading objects from local repository failed: "
-						+ x.getMessage(), x);
+				throw new TransportException(transport.getURI(),
+						"reading objects from local repository failed: "
+								+ x.getMessage(), x);
 			}
 			rru.setFastForward(fastForward);
 			if (!fastForward && !rru.isForceUpdate())
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index 6e49083..8a78099 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -82,12 +82,11 @@ class TransportGitAnon extends PackTransport {
 		try {
 			return new Socket(InetAddress.getByName(uri.getHost()), port);
 		} catch (IOException c) {
-			final String us = uri.toString();
 			if (c instanceof UnknownHostException)
-				throw new TransportException(us + ": Unknown host");
+				throw new TransportException(uri, "unknown host");
 			if (c instanceof ConnectException)
-				throw new TransportException(us + ": " + c.getMessage());
-			throw new TransportException(us + ": " + c.getMessage(), c);
+				throw new TransportException(uri, c.getMessage());
+			throw new TransportException(uri, c.getMessage(), c);
 		}
 	}
 
@@ -116,8 +115,8 @@ class TransportGitAnon extends PackTransport {
 				service("git-upload-pack", pckOut);
 			} catch (IOException err) {
 				close();
-				throw new TransportException(uri.toString()
-						+ ": remote hung up unexpectedly", err);
+				throw new TransportException(uri,
+						"remote hung up unexpectedly", err);
 			}
 			readAdvertisedRefs();
 		}
@@ -149,8 +148,8 @@ class TransportGitAnon extends PackTransport {
 				service("git-receive-pack", pckOut);
 			} catch (IOException err) {
 				close();
-				throw new TransportException(uri.toString()
-						+ ": remote hung up unexpectedly", err);
+				throw new TransportException(uri,
+						"remote hung up unexpectedly", err);
 			}
 			readAdvertisedRefs();
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index 55be4f6..46c60c3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -162,13 +162,12 @@ class TransportGitSsh extends PackTransport {
 				session.connect();
 			return session;
 		} catch (JSchException je) {
-			final String us = uri.toString();
 			final Throwable c = je.getCause();
 			if (c instanceof UnknownHostException)
-				throw new TransportException(us + ": Unknown host");
+				throw new TransportException(uri, "unknown host");
 			if (c instanceof ConnectException)
-				throw new TransportException(us + ": " + c.getMessage());
-			throw new TransportException(us + ": " + je.getMessage(), je);
+				throw new TransportException(uri, c.getMessage());
+			throw new TransportException(uri, je.getMessage(), je);
 		}
 	}
 
@@ -189,8 +188,7 @@ class TransportGitSsh extends PackTransport {
 			channel.connect();
 			return channel;
 		} catch (JSchException je) {
-			throw new TransportException(uri.toString() + ": "
-					+ je.getMessage(), je);
+			throw new TransportException(uri, je.getMessage(), je);
 		}
 	}
 
@@ -210,8 +208,8 @@ class TransportGitSsh extends PackTransport {
 				throw err;
 			} catch (IOException err) {
 				close();
-				throw new TransportException(uri.toString()
-						+ ": remote hung up unexpectedly", err);
+				throw new TransportException(uri,
+						"remote hung up unexpectedly", err);
 			}
 			readAdvertisedRefs();
 		}
@@ -255,8 +253,8 @@ class TransportGitSsh extends PackTransport {
 				throw err;
 			} catch (IOException err) {
 				close();
-				throw new TransportException(uri.toString()
-						+ ": remote hung up unexpectedly", err);
+				throw new TransportException(uri,
+						"remote hung up unexpectedly", err);
 			}
 			readAdvertisedRefs();
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index f48dc6d..761d1b8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -99,8 +99,7 @@ class TransportLocal extends PackTransport {
 			new StreamRewritingThread(proc.getErrorStream()).start();
 			return proc;
 		} catch (IOException err) {
-			throw new TransportException(uri.toString() + ": "
-					+ err.getMessage(), err);
+			throw new TransportException(uri, err.getMessage(), err);
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index cfe22c1..21657ef 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -111,13 +111,12 @@ class TransportSftp extends WalkTransport {
 				session.connect();
 			return session;
 		} catch (JSchException je) {
-			final String us = uri.toString();
 			final Throwable c = je.getCause();
 			if (c instanceof UnknownHostException)
-				throw new TransportException(us + ": Unknown host");
+				throw new TransportException(uri, "unknown host");
 			if (c instanceof ConnectException)
-				throw new TransportException(us + ": " + c.getMessage());
-			throw new TransportException(us + ": " + je.getMessage(), je);
+				throw new TransportException(uri, c.getMessage());
+			throw new TransportException(uri, je.getMessage(), je);
 		}
 	}
 
@@ -127,8 +126,7 @@ class TransportSftp extends WalkTransport {
 			channel.connect();
 			return (ChannelSftp) channel;
 		} catch (JSchException je) {
-			throw new TransportException(uri.toString() + ": "
-					+ je.getMessage(), je);
+			throw new TransportException(uri, je.getMessage(), je);
 		}
 	}
 
@@ -259,7 +257,7 @@ class TransportSftp extends WalkTransport {
 			} catch (FileNotFoundException notPacked) {
 				// Perhaps it wasn't worthwhile, or is just an older repository.
 			} catch (IOException e) {
-				throw new TransportException(uri + ": error in packed-refs", e);
+				throw new TransportException(uri, "error in packed-refs", e);
 			}
 			readRef(avail, "../HEAD", "HEAD");
 			readLooseRefs(avail, "../refs", "refs/");
-- 
1.5.5.3

From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PoC PATCH JGIT 1/2] Freenet Freenet Client Protocol
	(FCP) 2.0 Client
Date: Mon,  9 Mar 2009 11:36:04 +0800
Message-ID: <1236569765-8882-2-git-send-email-j16sdiz+freenet@gmail.com>
References: <1236569765-8882-1-git-send-email-j16sdiz+freenet@gmail.com>
Reply-To: Discussion of development issues <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Daniel Cheng \(aka SDiZ\)" <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org,
	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org Mon Mar 09 04:37:50 2009
Return-path: <devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
Envelope-to: gcfd-devl-602-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from emu.freenetproject.org ([89.16.176.201] helo=freenetproject.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgWJK-0005hs-E1
	for gcfd-devl-602-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Mar 2009 04:37:50 +0100
Received: by freenetproject.org (Postfix, from userid 108)
	id 10F7347872F; Mon,  9 Mar 2009 03:36:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	emu.dh.bytemark.co.uk
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=5.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO,SPF_PASS autolearn=unavailable version=3.1.7-deb3
Received: from emu.dh.bytemark.co.uk (localhost.localdomain [127.0.0.1])
	by freenetproject.org (Postfix) with ESMTP id 29B2C478720;
	Mon,  9 Mar 2009 03:36:25 +0000 (UTC)
X-Original-To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Delivered-To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Received: by freenetproject.org (Postfix, from userid 108)
	id E35B2478727; Mon,  9 Mar 2009 03:36:20 +0000 (UTC)
Received-SPF: pass (emu.dh.bytemark.co.uk: domain of j16sdiz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
	designates 209.85.198.248 as permitted sender)
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by freenetproject.org (Postfix) with ESMTP id E029D47870D
	for <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>; Mon,  9 Mar 2009 03:36:15 +0000 (UTC)
Received: by rv-out-0708.google.com with SMTP id k29so1354138rvb.10
	for <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>; Sun, 08 Mar 2009 20:36:14 -0700 (PDT)
Received: by 10.142.51.4 with SMTP id y4mr2320248wfy.303.1236569773933;
	Sun, 08 Mar 2009 20:36:13 -0700 (PDT)
Received: from localhost.localdomain (n058153086094.netvigator.com
	[58.153.86.94])
	by mx.google.com with ESMTPS id 29sm7732622wfg.53.2009.03.08.20.36.11
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Sun, 08 Mar 2009 20:36:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.rc2
In-Reply-To: <1236569765-8882-1-git-send-email-j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-BeenThere: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussion of development issues <devl.freenetproject.org>
List-Unsubscribe: <http://emu.freenetproject.org/cgi-bin/mailman/listinfo/devl>, 
	<mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://emu.freenetproject.org/pipermail/devl>
List-Post: <mailto:devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
List-Help: <mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=help>
List-Subscribe: <http://emu.freenetproject.org/cgi-bin/mailman/listinfo/devl>, 
	<mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=subscribe>
Sender: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Errors-To: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112674>


Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../jgit/transport/fcpv2/FCPConnection.java        |  427 ++++++++++++++++++++
 1 files changed, 427 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/fcpv2/FCPConnection.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/fcpv2/FCPConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/fcpv2/FCPConnection.java
new file mode 100644
index 0000000..ce2ca90
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/fcpv2/FCPConnection.java
@@ -0,0 +1,427 @@
+/*
+ * Copyright (C) 2008, CHENG Yuk-Pong, Daniel <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport.fcpv2;
+
+import java.io.BufferedInputStream;
+import java.io.BufferedOutputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.net.InetAddress;
+import java.net.Socket;
+import java.net.UnknownHostException;
+import java.util.HashMap;
+import java.util.Map;
+
+import org.spearce.jgit.lib.ProgressMonitor;
+
+/**
+ * Freenet Client Protocol 2.0 Connection
+ * 
+ * A simplified interface to Freenet 0.7 node using FCPv2. This is not a
+ * full-blown interface to Freenet node, but rather some "quick and dirty" hack
+ * just enough to upload/download simple file from the network.
+ * <p>
+ * See <a href="http://wiki.freenetproject.org/FreenetFCPSpec2Point0">Freenet
+ * Client Protocol 2.0 Specification</a> for detail on this protocol.
+ */
+public class FCPConnection {
+	/** Default FCP port */
+	public static final int DEFAULT_FCP_PORT = 9481;
+
+	protected InetAddress addr;
+
+	protected int port;
+
+	protected Socket socket;
+
+	protected InputStream is;
+
+	protected OutputStream os;
+
+	/**
+	 * Create a new FCP Connection to default host and port (
+	 * <code>localhost:9481</code>)
+	 * 
+	 * @throws UnknownHostException
+	 *             if no IP address for the <code>localhost</code> could be
+	 *             found.
+	 */
+	public FCPConnection() throws UnknownHostException {
+		this(InetAddress.getAllByName("127.0.0.1")[0], DEFAULT_FCP_PORT);
+	}
+
+	/**
+	 * Create a new FCP Connection to the specified IP address and port
+	 * 
+	 * @param address
+	 *            the node IP address
+	 * @param port
+	 *            the port number
+	 */
+	public FCPConnection(InetAddress address, int port) {
+		this.addr = address;
+		this.port = port;
+	}
+
+	/**
+	 * Connect to the node
+	 * 
+	 * @throws IOException
+	 *             if any I/O error occurred
+	 */
+	public void connect() throws IOException {
+		socket = new Socket(addr, port);
+
+		is = new BufferedInputStream(socket.getInputStream());
+		os = new BufferedOutputStream(socket.getOutputStream());
+	}
+
+	/**
+	 * Hello Message
+	 * 
+	 * Send handshake <code>ClientHello</code> message to node. Block until
+	 * <code>NodeHello</code> is received.
+	 * 
+	 * @param clientName
+	 *            Client name, must be unique in the freenet node
+	 * 
+	 * @throws IOException
+	 *             if any I/O error occurred
+	 */
+	public void hello(String clientName) throws IOException {
+		FCPMessage msg = new FCPMessage();
+		msg.messageType = "ClientHello";
+		msg.put("ExpectedVersion", "2.0");
+		msg.put("Name", clientName);
+
+		msg.writeTo(os);
+
+		while (true) {
+			FCPMessage reply = FCPMessage.parse(is);
+			if ("NodeHello".equals(reply.messageType))
+				return;
+			if ("ProtocolError".equals(reply.messageType))
+				throw new IOException("Protocol error");
+		}
+	}
+
+	/**
+	 * Simple FCP Put
+	 * 
+	 * This method block until the data are fetchable or <code>PutFailed</code>
+	 * received.
+	 * 
+	 * @param freenetURI
+	 *            the freenet URI
+	 * @param data
+	 *            the data to be put
+	 * @param monitor
+	 *            progress monitor to post write completion to during the
+	 *            stream's close method.
+	 * @param monitorTask
+	 *            task name to display during the close method.
+	 * @return <code>true</code> iff <code>PutFetchable</code>,
+	 *         <code>PutSuccessful</code> or <code>PutFetchable</code> with
+	 *         insert collision (data already inserted)
+	 * @throws IOException
+	 *             if any I/O error occurred
+	 */
+	public boolean simplePut(String freenetURI, byte[] data,
+			ProgressMonitor monitor, String monitorTask) throws IOException {
+		System.err.println(freenetURI);
+
+		FCPMessage msg = new FCPMessage();
+		msg.messageType = "ClientPut";
+		msg.put("URI", freenetURI);
+		msg.put("Identifier", freenetURI);
+		msg.put("Verbosity", "1");
+		msg.put("Global", "false");
+		msg.put("UploadFrom", "direct");
+		msg.put("DataLength", "" + data.length);
+		msg.extraData = data;
+
+		msg.writeTo(os);
+
+		int totalBlocks = -1;
+		int completedBlocks = 0;
+
+		try {
+			while (true) {
+				FCPMessage reply = FCPMessage.parse(is);
+
+				if ("ProtocolError".equals(reply.messageType))
+					throw new IOException("Protocol error");
+				if (!freenetURI.equals(reply.get("Identifier"))) // identifier don't match, ignore it
+					continue;
+				if ("IdentifierCollision".equals(reply.messageType))
+					throw new IOException("IdentifierCollision");
+
+				if ("PutFailed".equals(reply.messageType)) {
+					if ("9".equals(reply.get("Code"))) // collision, data already inserted
+						return true;
+					return false;
+				}
+
+				if ("SimpleProgress".equals(reply.messageType)) {
+					if (totalBlocks == -1) {
+						totalBlocks = Integer.parseInt(reply.get("Total"));
+						monitor.beginTask(monitorTask, totalBlocks);
+					}
+					int tmp = Integer.parseInt(reply.get("Succeeded"));
+					if (tmp < totalBlocks)
+						monitor.update(tmp - completedBlocks);
+					completedBlocks = tmp;
+				}
+
+				if ("PutSuccessful".equals(reply.messageType))
+					return true;
+				if ("PutFetchable".equals(reply.messageType))
+					return true;
+			}
+		} finally {
+			if (totalBlocks == -1)
+				monitor.beginTask(monitorTask, 1);
+			monitor.endTask();
+		}
+	}
+
+	/**
+	 * Simple FCP Get
+	 * 
+	 * @param freenetURI
+	 *            the freenet URI
+	 * @return the data
+	 * @throws IOException
+	 *             if any I/O error occurred
+	 * @throws FileNotFoundException
+	 *             if data not found
+	 */
+	public byte[] simpleGet(String freenetURI) throws IOException,
+			FileNotFoundException {
+		FCPMessage msg = new FCPMessage();
+		msg.messageType = "ClientGet";
+		msg.put("URI", freenetURI);
+		msg.put("Identifier", freenetURI);
+		msg.put("Verbosity", "1");
+		msg.put("MaxSize", "2147483647");
+		msg.put("Global", "false");
+		msg.put("ClientToken", freenetURI);
+		msg.put("ReturnType", "direct");
+
+		msg.writeTo(os);
+
+		while (true) {
+			FCPMessage reply = FCPMessage.parse(is);
+			if ("ProtocolError".equals(reply.messageType))
+				throw new IOException("Protocol error");
+			if (!freenetURI.equals(reply.get("Identifier"))) // identifier don't match, ignore it
+				continue;
+			if ("IdentifierCollision".equals(reply.messageType))
+				throw new IOException("IdentifierCollision");
+
+			if ("GetFailed".equals(reply.messageType)) {
+				String redirectURI = reply.get("RedirectURI");
+				if (redirectURI != null)
+					return simpleGet(redirectURI);
+
+				System.err.println(" -> nf");
+				throw new FileNotFoundException();
+			}
+
+			if ("AllData".equals(reply.messageType))
+				return reply.extraData;
+		}
+	}
+
+	/**
+	 * Generate SSK Key Pair
+	 * 
+	 * @return the generated SSK key pair. <code>key[0]</code> is the public
+	 *         key, <code>key[1]</code> is the private key.
+	 * @throws IOException
+	 *             if any I/O error occurred
+	 */
+	public String[] generateSSK() throws IOException {
+		FCPMessage msg = new FCPMessage();
+		msg.messageType = "GenerateSSK";
+		msg.put("Identifier", "GenerateSSK");
+
+		msg.writeTo(os);
+
+		while (true) {
+			FCPMessage reply = FCPMessage.parse(is);
+			if ("ProtocolError".equals(reply.messageType))
+				throw new IOException("Protocol error");
+
+			if ("SSKKeypair".equals(reply.messageType)) {
+				String[] keys = new String[2];
+				keys[0] = reply.get("RequestURI");
+				keys[1] = reply.get("InsertURI");
+				return keys;
+			}
+		}
+	}
+
+	/**
+	 * Close the connection
+	 * 
+	 * @throws IOException
+	 *             if any I/O error occurred
+	 */
+	public void close() throws IOException {
+		os.close();
+		is.close();
+		socket.close();
+	}
+
+	private static class FCPMessage {
+		private String messageType;
+
+		private Map<String, String> parameter = new HashMap<String, String>();
+
+		byte[] extraData;
+
+		FCPMessage() {
+			// default constructor
+		}
+
+		private static FCPMessage parse(InputStream in) throws IOException {
+			FCPMessage ret = new FCPMessage();
+			String line = readLine(in);
+			ret.messageType = line;
+
+			while (true) {
+				line = readLine(in);
+
+				if (line == null)
+					throw new IOException("Malformed FCP message");
+				if ("EndMessage".equals(line))
+					break;
+				if ("Data".equals(line)) {
+					String strLen = ret.parameter.get("DataLength");
+					if (strLen == null)
+						throw new IOException("DataLength not found");
+					int len;
+					try {
+						len = Integer.parseInt(strLen);
+					} catch (NumberFormatException e) {
+						throw new IOException("DataLength malformed");
+					}
+					ret.extraData = readData(in, len);
+					break;
+				}
+
+				String[] v = line.split("=", 2);
+				if (v.length != 2)
+					throw new IOException("No '=' found in: " + line);
+				ret.parameter.put(v[0], v[1]);
+			}
+
+			return ret;
+		}
+
+		void put(String key, String value) {
+			parameter.put(key, value);
+		}
+
+		String get(String key) {
+			return parameter.get(key);
+		}
+
+		void writeTo(OutputStream os) throws IOException {
+			os.write(messageType.getBytes("UTF-8"));
+			os.write('\n');
+
+			for (Map.Entry<String, String> e : parameter.entrySet()) {
+				String l = e.getKey() + '=' + e.getValue();
+				os.write(l.getBytes("UTF-8"));
+				os.write('\n');
+			}
+
+			os.write("EndMessage".getBytes("UTF-8"));
+			os.write('\n');
+
+			if (extraData != null)
+				os.write(extraData);
+			os.flush();
+		}
+	}
+
+	private static String readLine(InputStream in) throws IOException {
+		byte[] buf = new byte[256];
+		int offset = 0;
+
+		while (true) {
+			int b = in.read();
+			if (b == -1)
+				return null;
+			if (b == '\n') {
+				if (offset == 0)
+					continue; // skip empty line
+				break;
+			}
+
+			if (offset == buf.length) {
+				if (offset >= 4096)
+					throw new IOException("line too long");
+
+				byte[] buf2 = new byte[buf.length * 2];
+				System.arraycopy(buf, 0, buf2, 0, buf.length);
+				buf = buf2;
+			}
+
+			buf[offset++] = (byte) b;
+		}
+
+		return new String(buf, 0, offset, "UTF-8");
+	}
+
+	private static byte[] readData(InputStream in, int len) throws IOException {
+		byte[] buf = new byte[len];
+		int read = 0;
+		while (read < len) {
+			int r = in.read(buf, read, len - read);
+			if (r == -1)
+				throw new IOException("Not enough data");
+			read += r;
+		}
+		return buf;
+	}
+}
-- 
1.6.2.rc2

From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] zap a debug remnant
Date: Wed, 27 Sep 2006 15:30:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609271528260.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 21:30:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSf6w-0003Yo-Ck
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 21:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030670AbWI0TaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 15:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030674AbWI0TaX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 15:30:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10158 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030670AbWI0TaW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 15:30:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6900NB3NIL48O0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Sep 2006 15:30:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27922>


Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 6db97b6..16e98f3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -440,7 +440,6 @@ static unsigned long write_object(struct
 			+ entry->in_pack_header_size;
 		datalen = find_packed_object_size(p, entry->in_pack_offset)
 				- entry->in_pack_header_size;
-//fprintf(stderr, "reusing %d at %d header %d size %d\n", obj_type, entry->in_pack_offset, entry->in_pack_header_size, datalen);
 		if (!pack_to_stdout && check_inflate(buf, datalen, entry->size))
 			die("corrupt delta in pack %s", sha1_to_hex(entry->sha1));
 		sha1write(f, buf, datalen);

From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/2] Document some functions defined in object.c
Date: Fri, 28 Feb 2014 17:29:17 +0100
Message-ID: <1393604957-7571-3-git-send-email-mhagger@alum.mit.edu>
References: <1393604957-7571-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 17:30:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJQKE-0004ct-U3
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 17:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbaB1QaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 11:30:01 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52397 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752873AbaB1Q3y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 11:29:54 -0500
X-AuditID: 12074414-f79d96d000002d2b-45-5310b98213f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.57.11563.289B0135; Fri, 28 Feb 2014 11:29:54 -0500 (EST)
Received: from michael.fritz.box (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SGTLSf006566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 11:29:52 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393604957-7571-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqNu0UyDY4NhvfovbM1uYLbqudDNZ
	NPReYbZYcXUOs8Xbm0sYLW6vmM9sMe/FCzYHdo+/7z8weTw70c7msXPWXXaPi5eUPT5vkgtg
	jeK2SUosKQvOTM/Tt0vgzjh4ZApbwWLRiq1XXrE3MF4R6GLk5JAQMJG48PQgC4QtJnHh3nq2
	LkYuDiGBy4wSy788Z4VwjjNJ3OhaxghSxSagK7Gop5kJxBYRUJOY2HaIBaSIWWAik8TmI2/Y
	QRLCAs4SG9YdACtiEVCVaD+zEqyZFyi+8B2ELSGgINGybBdYPaeAi8SW6/+A6jmAtjlLzN/o
	O4GRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkEAT2cF45KTcIUYB
	DkYlHl7JRQLBQqyJZcWVuYcYJTmYlER5r+8ACvEl5adUZiQWZ8QXleakFh9ilOBgVhLhvbQY
	KMebklhZlVqUD5OS5mBREuf9tljdT0ggPbEkNTs1tSC1CCYrw8GhJMG7F2SoYFFqempFWmZO
	CUKaiYMTZDiXlEhxal5KalFiaUlGPCg24ouB0QGS4gHaexuknbe4IDEXKArReopRUUqcNwEk
	IQCSyCjNgxsLSx+vGMWBvhTm3QNSxQNMPXDdr4AGMwEN5vQEG1ySiJCSamA0EFv2PCbvE4/m
	8Yn3K/82zZSatPDm+gm1PYoTK+bpcnxt2OOqdHDtzYeKCrE/tjZVNDX1/X/Yl+sw2//TJ+kn
	BoavFFhXh5hEFaYp3FRJ9TnGIX5GlCOl+Nn7U6V72+JT4r4cn6nz8sDN3KrMd7rh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242984>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 object.c | 29 ++++++++++++++++++++++++++++-
 object.h |  7 +++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/object.c b/object.c
index 584f7ac..57a0890 100644
--- a/object.c
+++ b/object.c
@@ -43,14 +43,32 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
 
+/*
+ * Return a numerical hash value between 0 and n-1 for the object with
+ * the specified sha1.  n must be a power of 2.  Please note that the
+ * return value is *not* consistent across computer architectures.
+ */
 static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
 {
 	unsigned int hash;
+
+	/*
+	 * Since the sha1 is essentially random, we just take the
+	 * required number of bits directly from the first
+	 * sizeof(unsigned int) bytes of sha1.  First we have to copy
+	 * the bytes into a properly aligned integer.  If we cared
+	 * about getting consistent results across architectures, we
+	 * would have to call ntohl() here, too.
+	 */
 	memcpy(&hash, sha1, sizeof(unsigned int));
-	/* Assumes power-of-2 hash sizes in grow_object_hash */
 	return hash & (n - 1);
 }
 
+/*
+ * Insert obj into the hash table hash, which has length size (which
+ * must be a power of 2).  On collisions, simply overflow to the next
+ * empty bucket.
+ */
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
 	unsigned int j = hash_obj(obj->sha1, size);
@@ -63,6 +81,10 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
 	hash[j] = obj;
 }
 
+/*
+ * Look up the record for the given sha1 in the hash map stored in
+ * obj_hash.  Return NULL if it was not found.
+ */
 struct object *lookup_object(const unsigned char *sha1)
 {
 	unsigned int i, first;
@@ -92,6 +114,11 @@ struct object *lookup_object(const unsigned char *sha1)
 	return obj;
 }
 
+/*
+ * Increase the size of the hash map stored in obj_hash to the next
+ * power of 2 (but at least 32).  Copy the existing values to the new
+ * hash map.
+ */
 static void grow_object_hash(void)
 {
 	int i;
diff --git a/object.h b/object.h
index dc5df8c..732bf4d 100644
--- a/object.h
+++ b/object.h
@@ -42,7 +42,14 @@ struct object {
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
 
+/*
+ * Return the current number of buckets in the object hashmap.
+ */
 extern unsigned int get_max_object_index(void);
+
+/*
+ * Return the object from the specified bucket in the object hashmap.
+ */
 extern struct object *get_indexed_object(unsigned int);
 
 /*
-- 
1.8.5.3

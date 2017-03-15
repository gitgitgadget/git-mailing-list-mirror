Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A35D202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbdCOVQF (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:16:05 -0400
Received: from mout.web.de ([212.227.17.12]:63476 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbdCOVQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:16:04 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNs4-1cS6oa2AAi-00mbjb; Wed, 15
 Mar 2017 22:15:52 +0100
Subject: Re: Commiting files larger than 4 GB on Windows
To:     Jeff King <peff@peff.net>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
References: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66>
 <179b5d92-ee96-c2df-dbd8-eb96f7bbdb24@virtuell-zuhause.de>
 <20170315155952.x2tpiudi6rbqidvi@sigill.intra.peff.net>
 <20170315161308.sbyoxzst7ffcu6qs@sigill.intra.peff.net>
Cc:     Florian Adamus <florian-adamus@gmx.de>, git@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <93ccf86d-0090-a311-9825-7e23fd6a4141@web.de>
Date:   Wed, 15 Mar 2017 22:15:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170315161308.sbyoxzst7ffcu6qs@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:27i8wCjdrux15IrmXvxOGVFiDXG0dfElJ1Ph8f6k5PbBCTXYRGF
 xTPxyzI1E+XfKPD3fSlzMxB2bZaMb3RIYqQXYB8fl/YPcMaMt9kZYAP0ChuZPL3rz9f8lQW
 FkyW1wynGSD3QRF5bEp2CEdM0+t6ziwFIAvNXYluYlL0TLHaX7OH/wh/in+TFK3nV4l1j9a
 I03kT8wC8Y1GSwnzlhJ6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DNunz0Z1FBI=:2cxet0WPLMfR7kEzHw+eZ8
 jfQgNM5dxNguobfIHP2myRkjUOnGEpewB8d1rgJvOTqvIilZ5H6v9BjWu8p3jCd3kHrRIx5KA
 HyJUEaw4xzREsOllCKZG7kzy9BZ6du2cjP2ZuNVyh2n4+HX3S1hT/RVG9xM3K8/6EHsCUao5o
 ugoDBodwjBeJGIQ/K07BkK975COds00YkXUs8whptgsqqZCqS37/cR8AooQ5spB8JQsS6mp/7
 UQ8iLU9g3rLdvwWcMn4inbVUuPIarw5nyebuCQ7VRY0kPk+kuidZcf7lx7MzPyfEkGAEPEvFe
 qtgU+dMepnW+3ujur+J9xLIxnNeICFfcW6Ak/98Q/LJXiU7L+Lr/QOd8R24p9zTBxjv14Z0Fu
 zBo/uUz5xyp5diPQfBrooLjj9Tlwmq0riMnZ2SMy0TXt1wUtoPXW18ENEIEU6J3uYK7VTqm+b
 lkaCoZtoj/oRGPS7HFwA1IC1xESnR6NSG0l/++s5IDjphe97YqYbaFYuaDJkg2X5fuq64B1KL
 UXxNmdGJRQqFHfAT1QTAZOFqyqiBW0cvcyJTfa4ut33vTtY0Qch0of5K62IxXKw5Ncv1mqF+z
 Q+CdrmzgRTbZL5kAjwoFCMOaeofPi9AqmOfTk7FjRCTvoA2Ro8j/d40QOBa0gmxtjXTHH+A2k
 Np0N0rovWURKp34/nVeKE9C8s0geBd0kzz18pBucCbcT3KXUd90i+SGMFcUMDsGG5qIDkG2CS
 E0v+AfwEVy8l0FbN1IeCeQjySYuN6xX4fCokvSmC2XSqf6ct/a0nK19ALJ2e04fAAgcZdoaNm
 YZrrypU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-15 17:13, Jeff King wrote:
> On Wed, Mar 15, 2017 at 11:59:52AM -0400, Jeff King wrote:
> 
>> I agree that detecting the situation in the meantime is a good idea.
>> The patch above probably handles the bulk-checkin code path, I'd guess.
>> It might be nice to have similar checks in other places, too:
>>
>>   - when reading from an existing packfile
>>
>>     Looks like we may already have such a check in
>>     unpack_object_header_buffer().
>>
>>   - when taking in new objects via index-pack or unpack-objects (to
>>     catch a fetch of a too-big object)
>>
>>     I think index-pack.c:unpack_raw_entry() would want a similar check
>>     to what is in unpack_object_header_buffer().
> 
> Here are the results of a few quick experiments using two versions of
> git, one built for 32-bit and one for 64-bit:
> 
>   $ git init
>   $ dd if=/dev/zero of=foo.zero bs=1M count=4097
>   $ git32 add foo.zero
>   fatal: Cannot handle files this big
> 
> That comes from the xsize_t() wrapper. I guess it wouldn't trigger on
> Windows, though, because it is measuring size_t, not "unsigned long" (on
> my 32-bit build they are the same, of course).
> 
>   $ git64 add foo.zero
>   $ git32 cat-file blob :foo.zero
>   error: bad object header
>   fatal: packed object df6f032f301d1ce40477eefa505f2fac1de5e243 (stored in .git/objects/pack/pack-57d422f19904e9651bec43d10b7a9cd882de48ac.pack) is corrupt
> 
> So we notice, which is good. This is the message from
> unpack_object_header_buffer(). It might be worth improving the error
> message to mention the integer overflow.
> 
> And here's what index-pack looks like:
> 
>   $ git32 index-pack --stdin <.git/objects/pack/*.pack
>   fatal: pack has bad object at offset 12: inflate returned -5
> 
> It's good that we notice, but the error message isn't great. What
> happens is that we overflow the size integer, allocate a too-small
> buffer, and then zlib complains when we run out of buffer but there's
> still content to inflate. We probably ought to notice the integer
> overflow in the first place and complain there.
> 
> -Peff
> 

There is a bunch of problems when compiling on a 32 bit system.
size_t is 32 bit, but off_t is 64.
===================
Some fixes which improve things, (but Windows in the 64 bit version
has both size_t and off_t 64 bit, so this is a problem for a 32 bit system.
The real "show stopper" is at the end.


--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -183,7 +183,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,

 static int deflate_to_pack(struct bulk_checkin_state *state,
                           unsigned char result_sha1[],
-                          int fd, size_t size,
+                          int fd, off_t size,
                           enum object_type type, const char *path,
                           unsigned flags)
 {
@@ -252,7 +252,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 }

 int index_bulk_checkin(unsigned char *sha1,
-                      int fd, size_t size, enum object_type type,
+                      int fd, off_t size, enum object_type type,
                       const char *path, unsigned flags)
 {

diff --git a/bulk-checkin.h b/bulk-checkin.h
index fbd40fc..a385e61 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -5,7 +5,7 @@
 #define BULK_CHECKIN_H

 extern int index_bulk_checkin(unsigned char sha1[],
-                             int fd, size_t size, enum object_type type,
+                             int fd, off_t size, enum object_type type,
                              const char *path, unsigned flags);

 extern void plug_bulk_checkin(void);
diff --git a/diff.c b/diff.c
index 051761b..f1d7ac3 100644
--- a/diff.c
+++ b/diff.c
@@ -2857,7 +2857,9 @@ int diff_populate_filespec(struct diff_filespec *s,
unsigned int flags)
                                return err;
                        }
                }
-               s->size = xsize_t(st.st_size);
+               s->size = xoff_t(st.st_size);
+               if (s->size > (size_t) s->size)
+                       return 0;
                if (!s->size)
                        goto empty;
                if (S_ISLNK(st.st_mode)) {

=======================
After a while we run into the fact that Git wants to produce a diff:

diff --git a/diffcore.h b/diffcore.h
index 6230241..852214c 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -22,6 +22,15 @@

 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */

+static inline off_t xyoff_t(off_t len, const char *fff, int lll)
+{
+       if (len > (off_t) len)
+          die("Cannot handle files this big (%s:%d)", fff, lll);
+       return (off_t)len;
+}
+
+#define xoff_t(o) xyoff_t((o), __FILE__, __LINE__)
+
 struct userdiff_driver;

 struct diff_filespec {
@@ -29,7 +38,7 @@ struct diff_filespec {
        char *path;
        void *data;
        void *cnt_data;
-       unsigned long size;
+       off_t size;
        int count;               /* Reference count */
        int rename_used;         /* Count of rename users */
        unsigned short mode;     /* file mode */



diff --git a/git-compat-util.h b/git-compat-util.h
index ef6d560..318e998 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -881,13 +881,15 @@ static inline char *xstrdup_or_null(const char *str)
        return str ? xstrdup(str) : NULL;
 }

-static inline size_t xsize_t(off_t len)
+static inline size_t xysize_t(off_t len, const char *fff, int lll)
 {
        if (len > (size_t) len)
-               die("Cannot handle files this big");
+               die("Cannot handle files this big (%s:%d)", fff, lll);
        return (size_t)len;
 }

+#define xsize_t(o) xysize_t((o), __FILE__, __LINE__)
+
 __attribute__((format (printf, 3, 4)))
 extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);

diff --git a/sha1_file.c b/sha1_file.c
index ec957db..807123c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3561,7 +3561,7 @@ static int index_core(unsigned char *sha1, int fd, size_t
size,
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_stream(unsigned char *sha1, int fd, size_t size,
+static int index_stream(unsigned char *sha1, int fd, off_t size,
                        enum object_type type, const char *path,
                        unsigned flags)
 {
@@ -3586,7 +3586,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
                ret = index_core(sha1, fd, xsize_t(st->st_size), type, path,
                                 flags);
        else
-               ret = index_stream(sha1, fd, xsize_t(st->st_size), type, path,
+               ret = index_stream(sha1, fd, st->st_size, type, path,
                                   flags);
        close(fd);
        return ret;


==========================
And it seams as if zlib is the limitation here.
Unless we include the zlib source code into Git and redefine uLong,
is there a nice way around this:
===========================


/usr/include/zconf.h:#  define uLong                 z_uLong
/usr/include/zconf.h:#  define uLongf                z_uLongf
/usr/include/zconf.h:typedef unsigned long  uLong; /* 32 bits or more */
/usr/include/zconf.h:typedef uLong FAR uLongf;



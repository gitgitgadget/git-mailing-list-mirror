From: Michael Blume <blume.mike@gmail.com>
Subject: Deprecation warnings under XCode
Date: Sun, 30 Nov 2014 19:02:56 -0800
Message-ID: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 04:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvHHA-00083F-5Q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 04:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbaLADDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 22:03:18 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33675 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbaLADDR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 22:03:17 -0500
Received: by mail-oi0-f49.google.com with SMTP id i138so6742312oig.36
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 19:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=XC1z5PxHYDChz9PKU45Zgdzp7exPwzb1EWTLqTMAw6g=;
        b=moh3rFJvFQpiGc95O/TF1tKcIS/kn5MN8VTD1sNHi/zJ1ZK6wIN1CySbgdmiBt5uDr
         ZOcrAeO46hGoyBz/LwLVNvGxfs2roPmGM2VVHhRsTUIO/31SAAbTuiEl+J4k/5BeJgEN
         /Vw9bj49gUXPDuH1JfOg8cHDyQhMaIGRIr3y2L/7D5C1qmZx8WfDnCe92eV/JD8TZhuS
         2nZXWz1KDZDkV3fFnAlAMdQqD0+144Dw11nAsBmF7gROiuQZkk6XvuDQmjpPgLcA/7gs
         6g6CevFau1mgBHV2ENfHqAU2FAZFhjV863dzk9XX1fnUNQY5IWq8xEo/gopR0wq68OL3
         uApQ==
X-Received: by 10.202.49.131 with SMTP id x125mr32348638oix.17.1417402997153;
 Sun, 30 Nov 2014 19:03:17 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Sun, 30 Nov 2014 19:02:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260463>

I have no idea whether this should concern anyone, but my mac build of git shows

    CC imap-send.o
imap-send.c:183:36: warning: 'ERR_error_string' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
        fprintf(stderr, "%s: %s\n", func,
ERR_error_string(ERR_get_error(), NULL));
                                          ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/err.h:279:7:
note: 'ERR_error_string' has been explicitly marked deprecated here
char *ERR_error_string(unsigned long e,char *buf)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
      ^
imap-send.c:183:53: warning: 'ERR_get_error' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
        fprintf(stderr, "%s: %s\n", func,
ERR_error_string(ERR_get_error(), NULL));
                                                           ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/err.h:266:15:
note: 'ERR_get_error' has been explicitly marked deprecated here
unsigned long ERR_get_error(void) DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
              ^
imap-send.c:191:16: warning: 'SSL_get_error' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
                int sslerr = SSL_get_error(sock->ssl, ret);
                             ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1506:5:
note: 'SSL_get_error' has been explicitly marked deprecated here
int     SSL_get_error(const SSL *s,int ret_code)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:243:24: warning: 'X509_get_ext_d2i' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
        if ((subj_alt_names = X509_get_ext_d2i(cert,
NID_subject_alt_name, NULL, NULL))) {
                              ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/x509.h:1151:8:
note: 'X509_get_ext_d2i' has been explicitly marked deprecated here
void    *       X509_get_ext_d2i(X509 *x, int nid, int *crit, int
*idx) DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
                ^
imap-send.c:244:28: warning: 'sk_num' is deprecated: first deprecated
in OS X 10.7 [-Wdeprecated-declarations]
                int num_subj_alt_names = sk_GENERAL_NAME_num(subj_alt_names);
                                         ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/safestack.h:684:33:
note: expanded from macro 'sk_GENERAL_NAME_num'
#define sk_GENERAL_NAME_num(st) SKM_sk_num(GENERAL_NAME, (st))
                                ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/safestack.h:168:2:
note: expanded from macro 'SKM_sk_num'
        sk_num(st)
        ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/stack.h:81:5:
note: 'sk_num' has been explicitly marked deprecated here
int sk_num(const STACK *) DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
    ^
imap-send.c:246:34: warning: 'sk_value' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
                        GENERAL_NAME *subj_alt_name =
sk_GENERAL_NAME_value(subj_alt_names, i);
                                                      ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/safestack.h:685:38:
note: expanded from macro 'sk_GENERAL_NAME_value'
#define sk_GENERAL_NAME_value(st, i) SKM_sk_value(GENERAL_NAME, (st), (i))
                                     ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/safestack.h:170:11:
note: expanded from macro 'SKM_sk_value'
        ((type *)sk_value(st, i))
                 ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/stack.h:82:7:
note: 'sk_value' has been explicitly marked deprecated here
char *sk_value(const STACK *, int)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
      ^
imap-send.c:252:3: warning: 'sk_pop_free' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
                sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_free);
                ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/safestack.h:697:49:
note: expanded from macro 'sk_GENERAL_NAME_pop_free'
#define sk_GENERAL_NAME_pop_free(st, free_func)
SKM_sk_pop_free(GENERAL_NAME, (st), (free_func))
                                                ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/safestack.h:193:2:
note: expanded from macro 'SKM_sk_pop_free'
        sk_pop_free(st, (void (*)(void *))free_func)
        ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/stack.h:89:6:
note: 'sk_pop_free' has been explicitly marked deprecated here
void sk_pop_free(STACK *st, void (*func)(void *))
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
     ^
imap-send.c:258:15: warning: 'X509_get_subject_name' is deprecated:
first deprecated in OS X 10.7 [-Wdeprecated-declarations]
        if (!(subj = X509_get_subject_name(cert)))
                     ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/x509.h:1013:13:
note: 'X509_get_subject_name' has been explicitly marked deprecated
here
X509_NAME *     X509_get_subject_name(X509 *a)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
                ^
imap-send.c:260:13: warning: 'X509_NAME_get_text_by_NID' is
deprecated: first deprecated in OS X 10.7 [-Wdeprecated-declarations]
        if ((len = X509_NAME_get_text_by_NID(subj, NID_commonName,
cname, sizeof(cname))) < 0)
                   ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/x509.h:1098:7:
note: 'X509_NAME_get_text_by_NID' has been explicitly marked
deprecated here
int             X509_NAME_get_text_by_NID(X509_NAME *name, int nid,
                ^
imap-send.c:279:2: warning: 'SSL_library_init' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
        SSL_library_init();
        ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1558:5:
note: 'SSL_library_init' has been explicitly marked deprecated here
int SSL_library_init(void ) DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
    ^
imap-send.c:280:2: warning: 'SSL_load_error_strings' is deprecated:
first deprecated in OS X 10.7 [-Wdeprecated-declarations]
        SSL_load_error_strings();
        ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1421:6:
note: 'SSL_load_error_strings' has been explicitly marked deprecated
here
void    SSL_load_error_strings(void )
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:283:10: warning: 'TLSv1_method' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
                meth = TLSv1_method();
                       ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1524:13:
note: 'TLSv1_method' has been explicitly marked deprecated here
SSL_METHOD *TLSv1_method(void)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;           /* TLSv1.0 */
            ^
imap-send.c:285:10: warning: 'SSLv23_method' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
                meth = SSLv23_method();
                       ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1520:13:
note: 'SSLv23_method' has been explicitly marked deprecated here
SSL_METHOD *SSLv23_method(void)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;  /* SSLv3 but can
rollback to v2 */
            ^
imap-send.c:292:8: warning: 'SSL_CTX_new' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
        ctx = SSL_CTX_new(meth);
              ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1351:10:
note: 'SSL_CTX_new' has been explicitly marked deprecated here
SSL_CTX *SSL_CTX_new(SSL_METHOD *meth)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
         ^
imap-send.c:295:3: warning: 'SSL_CTX_set_verify' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
                SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
                ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1463:6:
note: 'SSL_CTX_set_verify' has been explicitly marked deprecated here
void SSL_CTX_set_verify(SSL_CTX *ctx,int mode,
     ^
imap-send.c:297:7: warning: 'SSL_CTX_set_default_verify_paths' is
deprecated: first deprecated in OS X 10.7 [-Wdeprecated-declarations]
        if (!SSL_CTX_set_default_verify_paths(ctx)) {
             ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1575:5:
note: 'SSL_CTX_set_default_verify_paths' has been explicitly marked
deprecated here
int SSL_CTX_set_default_verify_paths(SSL_CTX *ctx)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
    ^
imap-send.c:301:14: warning: 'SSL_new' is deprecated: first deprecated
in OS X 10.7 [-Wdeprecated-declarations]
        sock->ssl = SSL_new(ctx);
                    ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1486:7:
note: 'SSL_new' has been explicitly marked deprecated here
SSL *   SSL_new(SSL_CTX *ctx) DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:306:7: warning: 'SSL_set_rfd' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
        if (!SSL_set_rfd(sock->ssl, sock->fd[0])) {
             ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1376:5:
note: 'SSL_set_rfd' has been explicitly marked deprecated here
int     SSL_set_rfd(SSL *s, int fd)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:310:7: warning: 'SSL_set_wfd' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
        if (!SSL_set_wfd(sock->ssl, sock->fd[1])) {
             ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1377:5:
note: 'SSL_set_wfd' has been explicitly marked deprecated here
int     SSL_set_wfd(SSL *s, int fd)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:321:8: warning: 'SSL_ctrl' is deprecated: first deprecated
in OS X 10.7 [-Wdeprecated-declarations]
        ret = SSL_set_tlsext_host_name(sock->ssl, server.host);
              ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/tls1.h:149:42:
note: expanded from macro 'SSL_set_tlsext_host_name'
#define SSL_set_tlsext_host_name(s,name) \
                                         ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1501:6:
note: 'SSL_ctrl' has been explicitly marked deprecated here
long    SSL_ctrl(SSL *ssl,int cmd, long larg, void *parg)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:326:8: warning: 'SSL_connect' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
        ret = SSL_connect(sock->ssl);
              ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1497:6:
note: 'SSL_connect' has been explicitly marked deprecated here
int     SSL_connect(SSL *ssl) DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:334:10: warning: 'SSL_get_peer_certificate' is deprecated:
first deprecated in OS X 10.7 [-Wdeprecated-declarations]
                cert = SSL_get_peer_certificate(sock->ssl);
                       ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1455:8:
note: 'SSL_get_peer_certificate' has been explicitly marked deprecated
here
X509 *  SSL_get_peer_certificate(const SSL *s)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:350:7: warning: 'SSL_read' is deprecated: first deprecated
in OS X 10.7 [-Wdeprecated-declarations]
                n = SSL_read(sock->ssl, buf, len);
                    ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1498:6:
note: 'SSL_read' has been explicitly marked deprecated here
int     SSL_read(SSL *ssl,void *buf,int num)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:368:7: warning: 'SSL_write' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
                n = SSL_write(sock->ssl, buf, len);
                    ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1500:6:
note: 'SSL_write' has been explicitly marked deprecated here
int     SSL_write(SSL *ssl,const void *buf,int num)
DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
        ^
imap-send.c:385:3: warning: 'SSL_shutdown' is deprecated: first
deprecated in OS X 10.7 [-Wdeprecated-declarations]
                SSL_shutdown(sock->ssl);
                ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1537:5:
note: 'SSL_shutdown' has been explicitly marked deprecated here
int SSL_shutdown(SSL *s) DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;
    ^
imap-send.c:386:3: warning: 'SSL_free' is deprecated: first deprecated
in OS X 10.7 [-Wdeprecated-declarations]
                SSL_free(sock->ssl);
                ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/openssl/ssl.h:1495:6:
note: 'SSL_free' has been explicitly marked deprecated here
void    SSL_free(SSL *ssl) DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER;

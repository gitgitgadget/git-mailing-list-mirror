From: Jonathan <Xvakon@rocketmail.com>
Subject: smart http push setup/egit win7
Date: Wed, 5 Nov 2014 19:11:29 +0000 (UTC)
Message-ID: <1743053007.847058.1415214689002.JavaMail.yahoo@jws106105.mail.bf1.yahoo.com>
Reply-To: Jonathan <Xvakon@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 20:18:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm663-0004lJ-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 20:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbaKETST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 14:18:19 -0500
Received: from nm17-vm1.bullet.mail.bf1.yahoo.com ([98.139.213.55]:60134 "EHLO
	nm17-vm1.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750891AbaKETSS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2014 14:18:18 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Nov 2014 14:18:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1415214736; bh=J0fdaOFrOCz7n1z/tjyx0BWDdiGxTxbrHlzUNoKW+QY=; h=Date:From:Reply-To:To:Subject:From:Subject; b=Cz4Xhe5uYM9c8msZ3BRaMO6vqHJueTlWJhc7QNSKz1aA8v7ec7+drmxHeLZfqu352yOeUMeCbNH7MNt/+g7aR8AjoFQw8lHVU1av75P70sU6yFdkkxfgowUS/3KxnoVcEECz8M3CJo1pVMjtQBcYC8f0elbJSnEOgUp7hTZV/J4=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s1024; d=rocketmail.com;
	b=5FLUBIxYcyWkG3lphPQE5GFILjELKYhcAwhB8OD3wsJQOL/F+ZHWHqsTcDSJaD8wZov8WkQyFCoIpnm24bfVNUjRqhyDI5ce62QCqFa1+mrHnT1XuTeYB6tRON8TlvpTTcNHoj70IRgrqR2OaVZpuQBkeg1hRE6SjgW/LBxxGJA=;
Received: from [66.196.81.170] by nm17.bullet.mail.bf1.yahoo.com with NNFMP; 05 Nov 2014 19:12:16 -0000
Received: from [98.139.212.198] by tm16.bullet.mail.bf1.yahoo.com with NNFMP; 05 Nov 2014 19:12:16 -0000
Received: from [127.0.0.1] by omp1007.mail.bf1.yahoo.com with NNFMP; 05 Nov 2014 19:12:16 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 31334.23867.bm@omp1007.mail.bf1.yahoo.com
X-YMail-OSG: B0hqiO8VM1nevD4Rqcik8WfzKFE1pAtCXjYD9ZGczegEkIKys3GMbENFzWxNcAm
 f1pE_A5m7N4_xmJnjut0M.PYnsUqydbyJBP2JbeRxSNE054cF478jDuCzMoGZcSffMKs6SPsNNiz
 ziUnL_RtqBnUBaPbKBXxfOQXZq0nhiZAtbDrzTUN5fUbEXoLf83_InTURFRMRtFxWzq8pVlfLOhG
 KBPKBhtQ7ItKwqFuoT8vado9375nofuyGSgAP1JdubkTkFfWiwzVS1AgFs.yFCA86bW7j49zRilp
 CgqsMGn6DSAPLezWzIE4iuxYrjpPRkA8CvCNLUF.AokiaNwAnLmBbZApLwE0pNsZjj9_hLXgpIOM
 t.2wKkmikLFyby73YkOCjS1ssREMbW3mBNTLSbzpspFtScJKsrLV3gK0eyZRFCuJGR9LeqzOFGM.
 iMUrC2ne.ekn5iVpvOgxJke1NTkXkOGXb5pJDm4dJ5Bbz2AFwx3Bj3hj2_9oDGj1HS7X.3pFonBn
 0nsQTj1zbap8dG9ckshSs_Zih95Yl_uN4tto3qQ6u0u7Qm4tuMIy7NKpoT3HSgjMAZsND0vJviE.
 G4ZIZEaHhTijeXvMKL0Vt32rcz89eQP.R_1HXYa8PmUz2MyZ1vI9tcVEV5gTCt8yTOUsR9zFDuyy
 L.GLw5GgUM3ydXo51tR3Gk9MucKJ2qr7ig0gEi3OBfk9aRUrBdYsrOOcAr9jI7BIMoYS.g.6LjoK
 cDvknO6rFlNVra.8.ztZhs9CjqNda.sY7j0I_AyWfrFOW8VIfzkDipB2EA_wlCDQ1O212AZ0a99_
 hdQFZy9cM5W0i3QSqq1dCqY8WWUB856WgV2em3pB7S 
Received: by 76.13.27.49; Wed, 05 Nov 2014 19:12:15 +0000 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another smart http thread. I must have read dozens of threads and articles about setting this up but everyone seems to do it a little differently so I can't tell what's right and what's not. First up, the environment, which is the same for both server and test client...

Git 1.9.4
Eclipse Kepler SR2 with Egit
Windows 7
Server running Apache 2.2 with a bare repo

The client can connect to and successfully fetch the repo from the server over https. However, when trying to push egit gives the error "remote does not support http push." When attempting a push via bash, I get "return code 22 - fatal: git-http-push failed."

Note that this server is also serving other apps out via https, hence the other seemingly unrelated httpd entries. Eventually I will be implementing PKI authentication for read/write access but I will cross that bridge when I get to it. Also, ssh is not an option and neither is running it over plain text http so please don't bother trying to convice me to use them. Anyway, here is the httpd.conf. Forgive me for having to sanitize some of it.

ServerRoot "C:/progroot/servers/myserver"
ServerSignature Off
ServerTokens Prod
PidFile logs/httpsd.pid
Timeout 300
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 15
TraceEnable off
LoadModule alias_module         "C:/progroot/Apache2.2/modules/mod_alias.so"
LoadModule auth_basic_module  "C:/progroot/Apache2.2/modules/mod_auth_basic.so"
LoadModule auth_digest_module "C:/progroot/Apache2.2/modules/mod_auth_digest.so"
LoadModule authn_file_module "C:/progroot/Apache2.2/modules/mod_authn_file.so"
LoadModule authz_host_module  "C:/progroot/Apache2.2/modules/mod_authz_host.so"
LoadModule authz_user_module "C:/progroot/Apache2.2/modules/mod_authz_user.so"
LoadModule autoindex_module     "C:/progroot/Apache2.2/modules/mod_autoindex.so"
LoadModule dir_module           "C:/progroot/Apache2.2/modules/mod_dir.so"
LoadModule expires_module       "C:/progroot/Apache2.2/modules/mod_expires.so"
LoadModule headers_module       "C:/progroot/Apache2.2/modules/mod_headers.so"
LoadModule include_module       "C:/progroot/Apache2.2/modules/mod_include.so"
LoadModule log_config_module    "C:/progroot/Apache2.2/modules/mod_log_config.so"
LoadModule mime_module          "C:/progroot/Apache2.2/modules/mod_mime.so"
LoadModule negotiation_module   "C:/progroot/Apache2.2/modules/mod_negotiation.so"
LoadModule setenvif_module      "C:/progroot/Apache2.2/modules/mod_setenvif.so"
LoadModule jk_module            "C:/progroot/Apache2.2/modules/mod_jk.so"
LoadModule ssl_module    "C:/progroot/Apache2.2/modules/mod_ssl.so"
LoadModule cgi_module    "C:/progroot/Apache2.2/modules/mod_cgi.so"
LoadModule env_module    "C:/progroot/Apache2.2/modules/mod_env.so"
ThreadsPerChild     300
MaxRequestsPerChild 0
MaxMemFree  512
EnableSendfile   Off
EnableMMAP   Off
UseCanonicalName Off
TypesConfig conf/mime.types
DefaultType text/plain
HostnameLookups Off
##### Languages ######
AddLanguage en .en
LanguagePriority en 
AddDefaultCharset ISO-8859-1
BrowserMatch "Mozilla/2" nokeepalive
BrowserMatch "MSIE 4\.0b2;" nokeepalive downgrade-1.0 force-response-1.0
BrowserMatch "RealPlayer 4\.0" force-response-1.0
BrowserMatch "Java/1\.0" force-response-1.0
BrowserMatch "JDK/1\.0" force-response-1.0
Listen 443
SSLPassPhraseDialog builtin
SSLSessionCache shm:logs/safe/ssl_cache(512000)
SSLSessionCacheTimeout  300
SSLOptions +StdEnvVars +ExportCertData +OptRenegotiate
SSLProtocol +TLSv1
SSLMutex  default
SSLRandomSeed startup builtin
SSLRandomSeed connect builtin
SSLInsecureRenegotiation on
<VirtualHost _default_:443>
DocumentRoot "C:/progroot/servers/myserver/webapps" 
ServerName localhost:443
ServerAdmin mail@domain.com
ErrorLog logs/error.log
LogLevel error
SSLEngine on
SSLCertificateKeyFile ssl/mycert.key
SSLCertificateFile ssl/mycert.cer
SSLCipherSuite DHE-RSA-AES256-SHA:***
SetEnvIf User-Agent ".*MSIE.*" nokeepalive ssl-unclean-shutdown downgrade-1.0 force-response-1.0
SetEnvIf Request_URI \.gif$ dontlog
SetEnvIf Request_URI \.css$ dontlog
SetEnvIf Request_URI \.js$ dontlog
LogFormat "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %>s" common
CustomLog logs/access.log common env=!dontlog
<Directory "C:/progroot/servers/myserver/webapps/gitrepnewbare.git">
Allow from All
Options +ExecCGI
AllowOverride All
</Directory>
SetEnv GIT_PROJECT_ROOT "c:/progroot/servers/myserver/webapps"
SetEnv GIT_HTTP_EXPORT_ALL
SetEnv REMOTE_USER=$REDIRECT_REMOTE_USER
ScriptAlias /git-core/ "C:/devapps/Git/libexec/git-core/git-http-backend.exe"
</VirtualHost>

Any help trying to fix this file is appreciated

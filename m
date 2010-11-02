From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: detect the use of MUI langauge packs on Windows
Date: Tue, 2 Nov 2010 15:25:29 +0000
Message-ID: <874obztqku.fsf@fox.patthoyts.tk>
References: <AANLkTin6jP0N4gbiNU3=h0eYrYSOj-e65JfWS5tf1iSd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Michael Menegakis <arxeio@gmail.com>
X-From: msysgit+bncCM7pyrzTCBCl-sHmBBoEWVaroA@googlegroups.com Tue Nov 02 22:06:20 2010
Return-path: <msysgit+bncCM7pyrzTCBCl-sHmBBoEWVaroA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBCl-sHmBBoEWVaroA@googlegroups.com>)
	id 1PDO3b-0000up-Pw
	for gcvm-msysgit@m.gmane.org; Tue, 02 Nov 2010 22:06:15 +0100
Received: by wyi11 with SMTP id 11sf4420949wyi.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 02 Nov 2010 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:received:received:received:from:to
         :cc:cc:cc:subject:date:references:x-face:x-home-page:x-web:x-url
         :in-reply-to:message-id:user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=TXrSSIzwKlD8COzZCzk1aG6ApetDQ73hRC46dj0qffk=;
        b=leIe/zrHYureKrLjhMlci2w0epJMf2xsCbpB7WDc/sfACKXUuNXoCd66GV6Ljrc4ye
         Q5Unjf1Q4oeVlHdZjHxJ7jzZj0+RfGPYlqdfQsnwed7s8cMCCMCZSh9Qj+7AIre0+8c9
         mk2k6D36lSox2bZOXx/9TfY1ISRbNC3x2Jt8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:date:references:x-face
         :x-home-page:x-web:x-url:in-reply-to:message-id:user-agent
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        b=QziIleh7lUvUtLf55xhVoSS29TMDswscNNKAbzXaVWGhaYIAH1DYA4uirzDkMczFmf
         lUaG1Xl+wU7biM9SAE7TrhYFUv+MDYH0mBPxexVhcDrI+oICw1Loh9fEpFZjst0qcHc2
         qE5cOmeaE3lt90k2NYbyy+GWcVI2P9EB6RLS4=
Received: by 10.216.159.205 with SMTP id s55mr289569wek.12.1288731941501;
        Tue, 02 Nov 2010 14:05:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.208.4 with SMTP id p4ls219360weo.2.p; Tue, 02 Nov 2010
 14:05:40 -0700 (PDT)
Received: by 10.216.82.17 with SMTP id n17mr928113wee.6.1288731939976;
        Tue, 02 Nov 2010 14:05:39 -0700 (PDT)
Received: by 10.216.173.67 with SMTP id u45mr931043wel.7.1288730308442;
        Tue, 02 Nov 2010 13:38:28 -0700 (PDT)
Received: by 10.216.173.67 with SMTP id u45mr931042wel.7.1288730308400;
        Tue, 02 Nov 2010 13:38:28 -0700 (PDT)
Received: from smtp-out2.blueyonder.co.uk (smtp-out2.blueyonder.co.uk [195.188.213.5])
        by gmr-mx.google.com with ESMTP id x80si2415523weq.4.2010.11.02.13.38.28;
        Tue, 02 Nov 2010 13:38:28 -0700 (PDT)
Received-SPF: neutral (google.com: 195.188.213.5 is neither permitted nor denied by best guess record for domain of patthoyts@users.sourceforge.net) client-ip=195.188.213.5;
Received: from [172.23.144.246] (helo=asmtp-out2.blueyonder.co.uk)
	by smtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PDNcS-0002di-Us; Tue, 02 Nov 2010 20:38:15 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PDNWE-0006EW-K6; Tue, 02 Nov 2010 20:31:46 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id F042D250F1; Tue,  2 Nov 2010 20:31:45 +0000 (GMT)
Cc: msysgit <msysgit@googlegroups.com>
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
In-Reply-To: <AANLkTin6jP0N4gbiNU3=h0eYrYSOj-e65JfWS5tf1iSd@mail.gmail.com>
	(Michael Menegakis's message of "Sun, 31 Oct 2010 21:53:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Original-Sender: patthoyts@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 195.188.213.5 is neither permitted nor denied by best guess record for domain
 of patthoyts@users.sourceforge.net) smtp.mail=patthoyts@users.sourceforge.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160556>

The Tcl msgcat package doesn't detect the use of a multi-lingual language
pack on Windows 7. This means that a user may have their display language
set to Japanese but the system installed langauge was English.
This patch reads the relevent registry key to fix this before loading in
the locale specific parts of git-gui.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>Michael Menegakis <arxeio@gmail.com> writes:
>>For some unknown sorcery Microsoft does not refer to 'Locale' the same
>>as UNIX. There is only a display-characters method, only if a
>>character set is not unicode. For actual display of language they have
>>now on 7 a package downloading mechanism to have the whole system show
>>a language.
>>
>>On 7 right now I have locale on Greek so that any non-unicode programs
>>will work with that. But the display language is English and no Greek
>>or other non-English package has been installed. The location is also
>>Greece but that doesn't affect other programs either.
>>
>>In general these settings make almost all programs to display English
>>by default. Only a minority like git-gui don't.
>
>This is a fault in Tcl on Windows when you are making use of language
>packs to switch the display language on Vista or Windows 7. Tcl will
>correctly identify your system language but the newer language pack
>features make use of additional settings. See
>https://sourceforge.net/tracker/?func=detail&aid=3036566&group_id=10894&atid=110894
>for more on the Tcl issue.
>Until this is fixed upstream you can fix this for all Tcl/Tk programs
>(and many others) by ensuring that the LANG environment variable
>matches your display locale. ie: if you install the japanese language
>pack on an English version of Windows 7 and then set the display
>locale to japansese and set the LANG environment variable to LANG=ja
>then git gui would appear in Japanese. For Greek - use LANG=gr

It occurred to me that we do not actually have to wait for the patch
mentioned above to be applied to the tcl core. We can patch up the
msgcat package during git-gui startup and check the relevant registry
location to check for a MUI language pack.

This seems to work OK when I check on a Japanese pack on English Win7.

 git-gui.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d3acf0d..8cba1aa 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -93,6 +93,27 @@ if {![catch {set _verbose $env(GITGUI_VERBOSE)}]} {
 
 package require msgcat
 
+# Check for Windows 7 MUI language pack (missed by msgcat < 1.4.4)
+if {[tk windowingsystem] eq "win32"
+	&& [package vcompare [package provide msgcat] 1.4.4] < 0
+} then {
+	proc _mc_update_locale {} {
+		puts stderr "check for MUI pack"
+		set key {HKEY_CURRENT_USER\Control Panel\Desktop}
+		if {![catch {
+			package require registry
+			set uilocale [registry get $key "PreferredUILanguages"]
+			msgcat::ConvertLocale [string map {- _} [lindex $uilocale 0]]
+		} uilocale]} {
+			if {[string length $uilocale] > 0} {
+				puts stderr "update locale to $uilocale"
+				msgcat::mclocale $uilocale
+			}
+		}
+	}
+	_mc_update_locale
+}
+
 proc _mc_trim {fmt} {
 	set cmk [string first @@ $fmt]
 	if {$cmk > 0} {
-- 
1.7.3.1.msysgit.0

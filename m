From: =?ISO-8859-1?Q?B=F8rge_Bj=F8rnli_Nyg=E5rd?= 
	<borge.b.nygard@gmail.com>
Subject: Fwd: git-completion of branches containing @ in their name
Date: Fri, 5 Oct 2012 09:32:55 +0200
Message-ID: <CADWPBtdnimsQVD2VuLcCpUsTxAKMFZphoKRqseWy3D9JGxyTrA@mail.gmail.com>
References: <CADWPBtcVS-c_yTmWsWNQH7NgWVE6yoJNDv53RXF1E3cGwdQgHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2PD-0007XY-OC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab2JEHc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:32:57 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56784 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab2JEHc4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 03:32:56 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3073708iea.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=jy/ggCKoay6/XCpWFXIi4mi2qu4S7zH2jnQKPqpMezc=;
        b=blrUZDjnW0xsVj85IWRWpjM9IYk2JMvTCunqs0Imd9g0QbjZhbjOnu9i+6+jgks/gn
         dp474qb/aEPLEVoa9baSetJGZGh9k55tqdDMdBGObtbZVGVPsnyhGkZ0K7H0PaK14cAq
         grgV+TMsTzh3ctn03DPnd38SeCTt3hWBf8TxTkDlof9VRy1MuvvmPzxjRLupG+KrAtvs
         opA88U8I3ZiKJggR05ytdoNK3P/NMauKSTUfISCzeqkxpnaE1r+Pj4msgivh61qVc3vV
         52iZ4q2K6AeMQXjEqDgi81utPRirSRsFO1H5NyxQY4F9MqEnP48xnBZTLv2zxFUl5oTW
         PTUg==
Received: by 10.50.45.234 with SMTP id q10mr412566igm.33.1349422375783; Fri,
 05 Oct 2012 00:32:55 -0700 (PDT)
Received: by 10.231.82.195 with HTTP; Fri, 5 Oct 2012 00:32:55 -0700 (PDT)
In-Reply-To: <CADWPBtcVS-c_yTmWsWNQH7NgWVE6yoJNDv53RXF1E3cGwdQgHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207086>

Hello,

When I try to complete a branch name containing @, it doesn't expand
as expected.

Running git on Windows 7.

$ git --version
git version 1.7.11.msysgit.1

$ git branch
* master
  master@feature

If I write

$ git checkout master@

and press tab, the above expands to

$ git checkout mastermaster@feature

--
B=F8rge Bj=F8rnli Nyg=E5rd

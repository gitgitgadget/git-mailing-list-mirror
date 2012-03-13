From: Hallison Batista <hallison@codigorama.com>
Subject: [announce] Git Smart HTTP re-implementation in Ruby/Sinatra
Date: Tue, 13 Mar 2012 12:49:14 -0400
Message-ID: <CANr2nXqsu-ZaRevLqj6t=dP2VpQSL-0vV6c0Cdx9jkS_OJMbxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 17:49:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Uus-0005oH-A6
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 17:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab2CMQtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 12:49:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54878 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab2CMQtf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 12:49:35 -0400
Received: by yhmm54 with SMTP id m54so748601yhm.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 09:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:from:date:message-id:subject:to
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=BocWxAiDhO8tqgRrYHqAABFeoorWh8yy55VQmmJ67gE=;
        b=Lfri0ZcTV60J7Y61yiA5+52DDQ7Fha0Mffj+k67saS2v5HAIcAdr+FPkDLgu0vc/wm
         Rg8Zk8lEXmXa8Bv1NhvX6gQIPYdDQMouWhZ5zg3FllAJV/b8f7sFhkA+zWOng0QSjzGq
         abMSy+pJFAUQpsb+n6VLnE1elsG0fN5B82LCbHAOh3vj6xvf7DfS0RSJV1Jesfk3JCLL
         so2ORzhsnuVb8JaRRWLjO/ulpdHqYoajzJ++2b4em6RDEXvkG4Azy9/hIZx0boI3yPNo
         +wr3eUd3woLjGul3a8g3VHJKz+9r20gdPz4XaZ43VEXUIuIV2IbyS5Q+a17UZDZdSuF5
         ApHg==
Received: by 10.60.4.10 with SMTP id g10mr12400401oeg.18.1331657374248; Tue,
 13 Mar 2012 09:49:34 -0700 (PDT)
Received: by 10.182.5.129 with HTTP; Tue, 13 Mar 2012 09:49:14 -0700 (PDT)
X-Originating-IP: [200.208.153.196]
X-Gm-Message-State: ALoCoQnMlh3ir2wZEFHlXCRYXNn4eByzZBSFJBED9nSYLpIEy5spfA1WK4BVxaFfp0cAGUAPVdhI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193038>

Hello everyone,

I wrote a Web Application called Git::Webby.=C2=A0This project is a
Smart-HTTP server handler and has developed using=C2=A0Sinatra=C2=A0and=
 aims
replace the original "git-http-backend" including new features.

The main goal of the Git-Webby is implement the following useful featur=
es.

* Smart-HTTP, based on git-http-backend.
* Authentication flexible based on database or configuration file like
=2Ehtpasswd and .htgroup.
* API to get information about repository.

If you have interest, please, see the repository hosted on Github
(http://github.com/codigorama/git-webby).

=46eedback is welcome.

Thanks,

Hallison Batista

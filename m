From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.9.0 round 1
Date: Wed, 25 May 2016 00:03:00 +0800
Message-ID: <CANYiYbEHJVMuqYQA875Ao+3hTNUs6uMOHn5WNno4bS=0Y9Lk+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:03:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5EnT-0007oT-UB
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbcEXQDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 12:03:03 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35900 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbcEXQDB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 12:03:01 -0400
Received: by mail-qg0-f44.google.com with SMTP id q32so9319540qgq.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=N95LM+pJk80Q4esSJw9leegzcHEehdUE8rEwPb+Ae18=;
        b=t1I7XxtUaj7h+/bZKKzkOjvn+ww0TnqZqX/t4ah4pR5gQgc84+8Ra82u+tT3JxXFFO
         QtBJYnyqm04dM6vjwfrQ7ICYsv9B0cMQx2+Gxqrhs16+Tmuz4JECIDLjuAXSpiRLecWX
         3y4wUvhrd25uOif8rw7wKN+Ta5glM6iJl+V9Kdq4zIJVf7s8FT0T1uOSyb65O1D+tSvJ
         DBxCyM1yqQ9iy8ky4P1vHzGWPpufCk1KaCOiTe3p4oYi19wCbxjZUaP5sDid+FS4al4j
         dSYv5Abfmw4+B/mrBh/JNaRpEE9XnQ43bzbSdTpoU1QizpYHYlp8Rp8QYrj+Lxkv1QzI
         CszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=N95LM+pJk80Q4esSJw9leegzcHEehdUE8rEwPb+Ae18=;
        b=hjc8XBqIhH4tRiriSZBq9OFVO+VRlNWnw3GT68R3t9owpi2VkkxGZNzqaWHF75MAWr
         0SgVvJV4Ij/jgmOGS2AKPIng5O0Mb5uqZYpvUrbKYVujVxKgfepESacAxElEC9AgZdV1
         50kUaV/jmaiHV8qqw31RlXxeAkEly4BL+GchvQlVBvA78Mow5PZBJHd2oEgbrY9/QdqX
         TkPo3sVlmXt+awb2HlDwWI/qSKLH7Br/is38P5a20AX63SUbNmkrv8e9MDWrrQDyFTE1
         gEaSHGvzUtfTFSgIcAlRnaEvlUjJE223mEi3idHgvAKcjrzem7MAyAKqhXDo/KorNDJO
         C13A==
X-Gm-Message-State: ALyK8tLr8atZVZFb93xVbSHLpLqLUudGT4FwJ/xBlEq0xQ/8rkzSIuu+AWFbXCiYbRhGMVtgBDIxAjlB/H7Eaw==
X-Received: by 10.140.93.161 with SMTP id d30mr3924286qge.55.1464105780737;
 Tue, 24 May 2016 09:03:00 -0700 (PDT)
Received: by 10.55.74.2 with HTTP; Tue, 24 May 2016 09:03:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295497>

Hi guys,

Git v2.9.0-rc0 has been released, and it's time to start new round of g=
it l10n.
This time there are 104 updated messages need to be translated since la=
st
update:

    l10n: git.pot: v2.9.0 round 1 (104 new, 37 removed)

    Generate po/git.pot from v2.9.0-rc0 for git v2.9.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin

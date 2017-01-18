Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714BF20756
	for <e@80x24.org>; Wed, 18 Jan 2017 05:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbdARFZm (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 00:25:42 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35800 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdARFZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 00:25:41 -0500
Received: by mail-qt0-f173.google.com with SMTP id x49so2407450qtc.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 21:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ow+CrR4v2LZtrYjHrDUwWG71mvmehrtT09gPUsPEcXY=;
        b=UJJ6seDmkQcsv/HUu9x5W+2LZOtPtbpGJustkbiAM3spAtyKVS9OTBaWme3z15ggGV
         S93OuGxrI0AFfSaSE/G6odOmDaytzFLF571954lK//A2InLu54/zH8EWwdLAf/n4MjGG
         hZHOWYdGvaXm9vVaHl2nvm5S2kZHSieHLduIgQhUITdVultTvO/l15a+PXY7OvPm1kwk
         h1A7tr0tywB6IZuw0ssR3XXl2xtCLUglwNAyhgeVhYZP4580VDoQx0XhlBWTRULbtaRb
         jV1cUzwpqiCYJ0OddUGzjdpVs3jb+q/RDLbRcTDbTTn+a0yKdliqlBKnbLdguUOpbJhM
         rSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ow+CrR4v2LZtrYjHrDUwWG71mvmehrtT09gPUsPEcXY=;
        b=bWL9mPTWNyexGwFJ09SFIrIxB7MkGcFoialmWgOiJG4LCvkzlofWXNx8hxYq+X0G6X
         egrqA0gsKC2WrSKTCvhSg1VNg6bo8tQdHYGsRxvH4/SMA6AIV5yXICGzEvnIORilXVm+
         bJ8g4RUYAt+Qs9vNl+fUeNSdSc8WvE4IAGh9JexZYaVts03sNXHOGdsyku6MEild3RkA
         7dD7Atp0CP+nxElcbR0S+odce49Og+lH3TjqAaeNP7kmXcUFSPLvOf7yCqqUSdMyi5fG
         wwM58IeGRTpunerSIpHfBrLFzLMyuuY9vWqx2huKJJwwzJMQmsxrlGZPDEcgk9kRkRv1
         4Gnw==
X-Gm-Message-State: AIkVDXKqZNNNvGiIqLkUGg+5eO5R5goD2qEIGsm4AJNes9VYpBdrRJCsUVN4da4lciIcEcYZqJD/AmdAB+fCbQ==
X-Received: by 10.200.40.177 with SMTP id i46mr1152460qti.279.1484717043215;
 Tue, 17 Jan 2017 21:24:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.132 with HTTP; Tue, 17 Jan 2017 21:24:02 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Tue, 17 Jan 2017 23:24:02 -0600
Message-ID: <CAOc6etaCk=OEyarMNhorM94MBnYRscCkJBM-K08snv1ecmOaPQ@mail.gmail.com>
Subject: difflame
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

For a very long time I had wanted to get the output of diff to include
blame information as well (to see when something was added/removed).

I just created a very small (and rough) tool for that purpose. It's
written in python and if it gets to something better than a small
tool, I think it could be worth to be added into git main (perhaps
into contrib?).

If you want to give ir a try:
https://github.com/eantoranz/difflame

Just provide the two treeishs you would like to diff (no more
parameters are accepted at the time) and you will get the diff along
with blame. Running it right now on the project itself:

=E2=9C=94 ~/difflame [master L|=E2=9A=91 1]
23:21 $ ./difflame.py HEAD~3 HEAD~
diff --git a/README.txt b/README.txt
new file mode 100644
index 0000000..a82aa27
--- /dev/null
+++ b/README.txt
@@ -0,0 +1,11 @@
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  1) difflame
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  2)
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  3)
Copyright 2017 Edmundo Carmona Antoranz
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  4)
Released under the terms of GPLv2
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  5)
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  6) Show
the output of diff with the additional information of blame.
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  7)
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  8)
Lines that remain the same or that were added will indicate when those
lines were 'added' to the file
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600  9)
Lines that were removed will display the last revision where those
lines were _present_ on the file (as provided by blame --re
verse)
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600 10)
+3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600 11) At
the moment, only two parameters need to be provided: two treeishs to
get the diff from
diff --git a/difflame.py b/difflame.py
index f6e879b..06bfc03 100755
--- a/difflame.py
+++ b/difflame.py
@@ -112,16 +112,20 @@ def process_file_from_diff_output(output_lines,
starting_line):
c661286f (Edmundo Carmona Antoranz 2017-01-17 20:10:07 -0600 112)
diff_line =3D output_lines[i].split()
c661286f (Edmundo Carmona Antoranz 2017-01-17 20:10:07 -0600 113)
if diff_line[0] !=3D "diff":
c661286f (Edmundo Carmona Antoranz 2017-01-17 20:10:07 -0600 114)
   raise Exception("Doesn't seem to exist a 'diff' line at line " +
str(i + 1) + ": " + output_lines[i])
-3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600 115)
original_name =3D diff_line[1]
-3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600 116)
final_name =3D diff_line[2]
+f135bf04 (Edmundo Carmona Antoranz 2017-01-17 22:50:50 -0600 115)
original_name =3D diff_line[2]
+f135bf04 (Edmundo Carmona Antoranz 2017-01-17 22:50:50 -0600 116)
final_name =3D diff_line[3]
c661286f (Edmundo Carmona Antoranz 2017-01-17 20:10:07 -0600 117)
print output_lines[i]; i+=3D1
.
.
.


Hope you find it useful

Best regards!

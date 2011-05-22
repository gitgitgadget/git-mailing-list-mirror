From: Nir Friedman <nirfri@hotmail.com>
Subject: RE: FW: git over https and http 1.1
Date: Sun, 22 May 2011 09:04:50 +0300
Message-ID: <BLU0-SMTP212DEFAC09870015559B3F3C7730@phx.gbl>
References: <BLU0-SMTP122315AAE364595FDA4A30AC78F0@phx.gbl>	<alpine.DEB.2.00.1105181615180.26343@tvnag.unkk.fr>	<BLU0-SMTP207861424D1FA595A51BBBEC78E0@phx.gbl> <BANLkTin6LQ-UoaJObJ3pyJOp0TfeJXw9Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 08:05:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO1mm-0008QC-0e
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 08:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171Ab1EVGEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 02:04:54 -0400
Received: from blu0-omc3-s21.blu0.hotmail.com ([65.55.116.96]:50749 "EHLO
	blu0-omc3-s21.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126Ab1EVGEw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2011 02:04:52 -0400
Received: from BLU0-SMTP212 ([65.55.116.73]) by blu0-omc3-s21.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sat, 21 May 2011 23:04:52 -0700
X-Originating-IP: [212.179.48.132]
X-Originating-Email: [nirfri@hotmail.com]
Received: from nirftp ([212.179.48.132]) by BLU0-SMTP212.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Sat, 21 May 2011 23:04:50 -0700
In-Reply-To: <BANLkTin6LQ-UoaJObJ3pyJOp0TfeJXw9Qw@mail.gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcwWPirfVP2cuSUFTIyzzxKa4z1PHwCB9hKQ
Content-Language: en-us
X-OriginalArrivalTime: 22 May 2011 06:04:50.0595 (UTC) FILETIME=[29433730:01CC1846]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174180>

I am using a self signed cert

See below output of : openssl s_client -connect IP:443 -debug

---
depth=0 /CN=ubuntu
verify error:num=18:self signed certificate
verify return:1
depth=0 /CN=ubuntu
verify return:1
CONNECTED(00000003)
write to 0x688ae0 [0x688b60] (136 bytes => 136 (0x88))
0000 - 80 86 01 03 01 00 5d 00-00 00 20 00 00 39 00 00   ......]... ..9..
0010 - 38 00 00 35 00 00 88 00-00 87 00 00 84 00 00 16   8..5............
0020 - 00 00 13 00 00 0a 07 00-c0 00 00 33 00 00 32 00   ...........3..2.
0030 - 00 2f 00 00 45 00 00 44-00 00 41 03 00 80 00 00   ./..E..D..A.....
0040 - 05 00 00 04 01 00 80 00-00 15 00 00 12 00 00 09   ................
0050 - 06 00 40 00 00 14 00 00-11 00 00 08 00 00 06 04   ..@.............
0060 - 00 80 00 00 03 02 00 80-b4 d2 1f b9 c6 a3 0e 50   ...............P
0070 - 2a ed fa 4c e6 68 85 b5-4a 11 44 8e bb e9 bd c0   *..L.h..J.D.....
0080 - 39 54 82 a4 36 0b 8a 4a-                          9T..6..J
read from 0x688ae0 [0x68e0c0] (7 bytes => 7 (0x7))
0000 - 16 03 01 00 4a 02                                 ....J.
0007 - <SPACES/NULS>
read from 0x688ae0 [0x68e0c7] (72 bytes => 72 (0x48))
0000 - 00 46 03 01 4d d8 a6 c0-c7 e3 fb ad 40 41 49 64   .F..M.......@AId
0010 - 50 6c 5e 4a 4d 50 1e f7-dc 9f d7 28 de f3 8a b5   Pl^JMP.....(....
0020 - 74 dd 8e 13 20 35 52 9b-eb 05 2f 61 cf 9c 4d f0   t... 5R.../a..M.
0030 - e9 94 e7 86 4e df c1 eb-19 b0 7d 53 4d d4 18 a9   ....N.....}SM...
0040 - ad 09 d1 b7 9d 00 39                              ......9
0048 - <SPACES/NULS>
read from 0x688ae0 [0x68e0c0] (5 bytes => 5 (0x5))
0000 - 16 03 01 01 a7                                    .....
read from 0x688ae0 [0x68e0c5] (423 bytes => 423 (0x1A7))
0000 - 0b 00 01 a3 00 01 a0 00-01 9d 30 82 01 99 30 82   ..........0...0.
0010 - 01 02 02 09 00 ad ea b7-4f 4b 2f 3b 50 30 0d 06   ........OK/;P0..
0020 - 09 2a 86 48 86 f7 0d 01-01 05 05 00 30 11 31 0f   .*.H........0.1.
0030 - 30 0d 06 03 55 04 03 13-06 75 62 75 6e 74 75 30   0...U....ubuntu0
0040 - 1e 17 0d 30 39 30 39 30-39 31 33 30 39 30 38 5a   ...090909130908Z
0050 - 17 0d 31 39 30 39 30 37-31 33 30 39 30 38 5a 30   ..190907130908Z0
0060 - 11 31 0f 30 0d 06 03 55-04 03 13 06 75 62 75 6e   .1.0...U....ubun
0070 - 74 75 30 81 9f 30 0d 06-09 2a 86 48 86 f7 0d 01   tu0..0...*.H....
0080 - 01 01 05 00 03 81 8d 00-30 81 89 02 81 81 00 ef   ........0.......
0090 - ac 2f c8 f5 6e 8d 46 d6-9d 33 23 69 8d 7a 00 25   ./..n.F..3#i.z.%
00a0 - 7d 76 45 97 14 81 0a 7b-4f d7 dc 1a 37 b0 9f 22   }vE....{O...7.."
00b0 - a3 8f 25 f6 75 91 ab 58-da 6a 27 76 b9 42 83 ae   ..%.u..X.j'v.B..
00c0 - c7 25 f9 e3 8c 33 02 4f-57 a5 a2 45 40 bf 0d c3   .%...3.OW..E@...
00d0 - 55 77 69 fe 8e 89 bf 3a-d8 2b 3e 04 45 84 9e e1   Uwi....:.+>.E...
00e0 - ef 31 1e 47 8a b4 39 0b-b3 ca b8 00 0e b6 ef fd   .1.G..9.........
00f0 - e7 9c f7 8e 07 f5 dd 93-dd 4e 9e ad cf e2 48 2c   .........N....H,
0100 - 29 ce 86 a9 a0 df 2d 05-33 6e 3b 74 0a ad 95 02   ).....-.3n;t....
0110 - 03 01 00 01 30 0d 06 09-2a 86 48 86 f7 0d 01 01   ....0...*.H.....
0120 - 05 05 00 03 81 81 00 41-cc 5b 89 c7 a6 4e e8 77   .......A.[...N.w
0130 - b6 52 24 4a 12 95 f2 bc-52 90 38 91 b7 b6 5f 3e   .R$J....R.8..._>
0140 - 43 5b a2 72 b3 ce bd b7-9b 3e 29 58 29 ae e9 e2   C[.r.....>)X)...
0150 - 54 df e7 7f 91 99 bb f3-7a 71 8e b3 77 01 dc e8   T.......zq..w...
0160 - 63 54 21 3e a4 08 9a 0a-dd 16 9c 95 17 20 33 ec   cT!>......... 3.
0170 - 29 23 0a cc 3c 02 24 de-a0 d7 6c 62 35 ca 93 ef   )#..<.$...lb5...
0180 - 3e e8 fd 6f cb 39 13 38-97 c0 54 3b ed ff 8e 9a   >..o.9.8..T;....
0190 - 17 ab 41 47 9e 42 ee 08-47 3c bf 50 27 2c 13 bc   ..AG.B..G<.P',..
01a0 - 65 cb 21 ee ef a1 db                              e.!....
read from 0x688ae0 [0x68e0c0] (5 bytes => 5 (0x5))
0000 - 16 03 01 01 8d                                    .....
read from 0x688ae0 [0x68e0c5] (397 bytes => 397 (0x18D))
0000 - 0c 00 01 89 00 80 d6 7d-e4 40 cb bb dc 19 36 d6   .......}.@....6.
0010 - 93 d3 4a fd 0a d5 0c 84-d2 39 a4 5f 52 0b b8 81   ..J......9._R...
0020 - 74 cb 98 bc e9 51 84 9f-91 2e 63 9c 72 fb 13 b4   t....Q....c.r...
0030 - b4 d7 17 7e 16 d5 5a c1-79 ba 42 0b 2a 29 fe 32   ...~..Z.y.B.*).2
0040 - 4a 46 7a 63 5e 81 ff 59-01 37 7b ed dc fd 33 16   JFzc^..Y.7{...3.
0050 - 8a 46 1a ad 3b 72 da e8-86 00 78 04 5b 07 a7 db   .F..;r....x.[...
0060 - ca 78 74 08 7d 15 10 ea-9f cc 9d dd 33 05 07 dd   .xt.}.......3...
0070 - 62 db 88 ae aa 74 7d e0-f4 d6 e2 bd 68 b0 e7 39   b....t}.....h..9
0080 - 3e 0f 24 21 8e b3 00 01-02 00 80 a6 1b f0 32 6c   >.$!..........2l
0090 - 65 fb ca f7 33 5a 45 6d-da 0d 6e 64 cb bb 06 5c   e...3ZEm..nd...\
00a0 - 47 38 ff e0 f6 77 dd 3f-20 4b b2 0d f1 79 eb d6   G8...w.? K...y..
00b0 - 07 b5 3b 48 cd 9b 90 2e-3b 91 55 76 96 2f 37 39   ..;H....;.Uv./79
00c0 - 14 a2 c7 e1 f0 4b af d1-2a fb bc 32 c0 e6 f2 92   .....K..*..2....
00d0 - ac 56 c5 df 2c 33 e0 a2-1d 78 aa d2 3c 92 50 2c   .V..,3...x..<.P,
00e0 - af ac ba 72 da ca 51 6a-03 e1 af f8 2d bf 9c d9   ...r..Qj....-...
00f0 - d7 84 19 ab 8b b1 a0 85-d3 40 fd 0b 45 07 62 ab   .........@..E.b.
0100 - 6d 94 d4 fa ad 88 89 6c-c8 11 46 00 80 1b 94 ae   m......l..F.....
0110 - 9e a8 c4 73 e3 68 3a f2-0d 70 18 d0 8e 26 37 a5   ...s.h:..p...&7.
0120 - cd a7 6e 39 74 72 25 13-8f 48 83 b6 70 1a 92 90   ..n9tr%..H..p...
0130 - a3 e1 65 b3 1c 0f 4d 1a-c6 95 fb 1e ac 9a 32 2e   ..e...M.......2.
0140 - b4 9a 86 44 ef e8 79 db-9d cc 3e 85 76 20 4e 76   ...D..y...>.v Nv
0150 - 5e 30 78 82 f0 be f0 87-44 1b 89 b8 f4 00 58 74   ^0x.....D.....Xt
0160 - d2 98 5c 6d 57 7c 24 e2-7f 62 cf 8f e4 c3 c6 f3   ..\mW|$..b......
0170 - 29 f2 2d 5f f0 5c 7b 92-3e b4 9e 1b fb c1 7e 0f   ).-_.\{.>.....~.
0180 - 51 1b 83 44 f0 74 f4 71-f9 52 79 6b 34            Q..D.t.q.Ryk4
read from 0x688ae0 [0x68e0c0] (5 bytes => 5 (0x5))
0000 - 16 03 01 00 04                                    .....
read from 0x688ae0 [0x68e0c5] (4 bytes => 4 (0x4))
0000 - 0e                                                .
0004 - <SPACES/NULS>
write to 0x688ae0 [0x6983f0] (139 bytes => 139 (0x8B))
0000 - 16 03 01 00 86 10 00 00-82 00 80 56 d4 69 01 20   ...........V.i. 
0010 - c4 eb 24 a8 69 91 4b 15-ec 7d 2c f8 06 97 16 4c   ..$.i.K..},....L
0020 - 73 0c 13 32 78 de 6d e9-02 59 00 3a 62 de ba de   s..2x.m..Y.:b...
0030 - 91 a9 db b5 8f e2 0e 55-a6 7a 85 11 fd e2 ae 16   .......U.z......
0040 - 0e 61 b7 f7 b9 ec 1e 7f-2c 1e 9a 6d dc b2 83 7c   .a......,..m...|
0050 - 7e 58 a3 90 07 2c 41 75-d5 56 f6 f3 5f e3 6c d5   ~X...,Au.V.._.l.
0060 - af a4 5d bc 20 92 e5 f6-c8 90 f8 a3 39 3e 38 1b   ..]. .......9>8.
0070 - 23 be 14 e8 4f eb 48 bb-06 7a 50 52 bf ce 9c 29   #...O.H..zPR...)
0080 - 66 b6 ee eb e7 cb dc fe-de a2 be                  f..........
write to 0x688ae0 [0x6983f0] (6 bytes => 6 (0x6))
0000 - 14 03 01 00 01 01                                 ......
write to 0x688ae0 [0x6983f0] (53 bytes => 53 (0x35))
0000 - 16 03 01 00 30 a1 2e 39-13 94 e1 2f 6c 3d 9b c3   ....0..9.../l=..
0010 - 25 73 b7 aa 9b 86 61 53-53 fa f6 16 f2 b0 27 43   %s....aSS.....'C
0020 - a4 b2 24 f2 30 ef 59 b5-cd d9 44 61 41 23 b0 b8   ..$.0.Y...DaA#..
0030 - c7 64 c2 3a 42                                    .d.:B
read from 0x688ae0 [0x68e0c0] (5 bytes => 5 (0x5))
0000 - 14 03 01 00 01                                    .....
read from 0x688ae0 [0x68e0c5] (1 bytes => 1 (0x1))
0000 - 01                                                .
read from 0x688ae0 [0x68e0c0] (5 bytes => 5 (0x5))
0000 - 16 03 01 00 30                                    ....0
read from 0x688ae0 [0x68e0c5] (48 bytes => 48 (0x30))
0000 - 79 9f 39 73 20 96 de b4-a9 9d 3b fa b5 8d cc c7   y.9s .....;.....
0010 - 70 b7 51 20 91 17 d4 d7-05 87 bb be d8 ad 76 0f   p.Q ..........v.
0020 - 9e 75 88 60 1a 2b 33 3d-01 8d ef 0d 67 3b 33 ca   .u.`.+3=....g;3.
---
Certificate chain
 0 s:/CN=ubuntu
   i:/CN=ubuntu
---
Server certificate
-----BEGIN CERTIFICATE-----
MIIBmTCCAQICCQCt6rdPSy87UDANBgkqhkiG9w0BAQUFADARMQ8wDQYDVQQDEwZ1
YnVudHUwHhcNMDkwOTA5MTMwOTA4WhcNMTkwOTA3MTMwOTA4WjARMQ8wDQYDVQQD
EwZ1YnVudHUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAO+sL8j1bo1G1p0z
I2mNegAlfXZFlxSBCntP19waN7CfIqOPJfZ1katY2mondrlCg67HJfnjjDMCT1el
okVAvw3DVXdp/o6JvzrYKz4ERYSe4e8xHkeKtDkLs8q4AA627/3nnPeOB/Xdk91O
nq3P4kgsKc6GqaDfLQUzbjt0Cq2VAgMBAAEwDQYJKoZIhvcNAQEFBQADgYEAQcxb
icemTuh3tlIkShKV8rxSkDiRt7ZfPkNbonKzzr23mz4pWCmu6eJU3+d/kZm783px
jrN3AdzoY1QhPqQImgrdFpyVFyAz7CkjCsw8AiTeoNdsYjXKk+8+6P1vyzkTOJfA
VDvt/46aF6tBR55C7ghHPL9QJywTvGXLIe7vods=
-----END CERTIFICATE-----
subject=/CN=ubuntu
issuer=/CN=ubuntu
---
No client certificate CA names sent
---
SSL handshake has read 977 bytes and written 334 bytes
---
New, TLSv1/SSLv3, Cipher is DHE-RSA-AES256-SHA
Server public key is 1024 bit
Compression: NONE
Expansion: NONE
SSL-Session:
    Protocol  : TLSv1
    Cipher    : DHE-RSA-AES256-SHA
    Session-ID:
35529BEB052F61CF9C4DF0E994E7864EDFC1EB19B07D534DD418A9AD09D1B79D
    Session-ID-ctx: 
    Master-Key:
07980712BCB7DB6ADC7BA3FD4D81EA4CFCBA176D275C1C73E47350608271317747EB7D0DC3A5
B5CE6D5AF9EE317D3F37
    Key-Arg   : None
    Start Time: 1306044096
    Timeout   : 300 (sec)
    Verify return code: 18 (self signed certificate)
---
read from 0x688ae0 [0x68e0c0] (5 bytes => 5 (0x5))
0000 - 15 03 01                                          ...
0005 - <SPACES/NULS>
read from 0x688ae0 [0x68e0c5] (32 bytes => 32 (0x20))
0000 - 39 5b 33 4b 74 4c 96 a3-9c 8a b8 5c 62 2c 08 ff   9[3KtL.....\b,..
0010 - c9 0e 47 2a 0b 2b 39 20-05 70 e6 9a 6d 26 65 a9   ..G*.+9 .p..m&e.
closed
write to 0x688ae0 [0x6928d0] (37 bytes => 37 (0x25))
0000 - 15 03 01 00 20 6a 30 d1-23 90 d2 0b 5c 61 a9 08   .... j0.#...\a..
0010 - 02 81 74 21 34 fc b3 c2-51 84 2d b9 79 85 17 b3   ..t!4...Q.-.y...
0020 - d9 b1 32 dd 43                                    ..2.C

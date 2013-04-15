From: Ilya Basin <basinilya@gmail.com>
Subject: Re: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage: invalid argument --norc)
Date: Mon, 15 Apr 2013 21:58:18 +0400
Message-ID: <1762779000.20130415215818@gmail.com>
References: <323381594.20130414121834@gmail.com> <673219382.20130414124800@gmail.com> <20130414113351.GA1299@thyrsus.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------1089522C21CF43EE"
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:00:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnh7-0008VK-Nb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab3DOR7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:59:52 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:63379 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab3DOR7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:59:51 -0400
Received: by mail-la0-f53.google.com with SMTP id fp13so4600363lab.40
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type;
        bh=anc46h6wLB4hbSadCgyXH60dluxx6xbwFnh+vFspbeU=;
        b=QmogthF9Bl8KJAq6kODEnl8Tc8Vxa4XSdxboNDVFKUVhcO2F/rkjJj0Cu08wTAuToV
         3FsF2aLioB7Ebghgcd+5IuURxSNQX5zbyjP31O2IeltCq1fC3MS1gFpT43gqTYLppuZS
         Fn9aKPK6fuQGF16QhsFCZdEg9jWGBcacu+Ki28F2GdhkXPSFe4m6f/zBXiiU1U9ZJc+r
         fcxGnkmzEek/l8V+XQlYMUG/weHH+pnri088sz8uaJO1a+z8Q5QU6eZVx4qbqGElkbNP
         XK3vDT5oO5N+f0DTJKiT6sq7UikYSw9lJxneDVgPH8Gm2PFMhyKxlhxv654Qm5Kql0+g
         7hkQ==
X-Received: by 10.112.125.134 with SMTP id mq6mr4239712lbb.33.1366048790138;
        Mon, 15 Apr 2013 10:59:50 -0700 (PDT)
Received: from [192.168.0.78] (92-100-233-187.dynamic.avangarddsl.ru. [92.100.233.187])
        by mx.google.com with ESMTPS id x9sm8245510lbi.15.2013.04.15.10.59.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 10:59:48 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20130414113351.GA1299@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221276>

------------1089522C21CF43EE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Eric.

I tried --fast-export. It's 2 times faster.
The first thing that differs: in cvsps2 commits with adjacent
timestamps were joined into one (see the attached files). Do you know
the reason?

Does this --fast-export thing support what John mentioned, the
"incremental import support"? Does 'git fast-import' has it?
I need it, because full import takes too long.
The central repo of my employer is CVS, other people commit to it and
I use git internally to be able to tidy my commit history before
exporting to CVS.

-- 
------------1089522C21CF43EE
Content-Type: TEXT/PLAIN;
 name="cvsps2.txt"
Content-transfer-encoding: base64
Content-Disposition: attachment;
 filename="cvsps2.txt"

Y3ZzcHMyOgoKY29tbWl0IGMwNjU0ODQ1NzkxZGExZWVmYjFlMjIzYzgwMDExNjlkNjFmOWRl
NTEKQXV0aG9yOiByZWV2emgxIDxyZWV2emgxPgpEYXRlOiAgIEZyaSBKdWwgMjggMTA6NDc6
MTcgMjAwNiArMDAwMAoKICAgIG5vIG1lc3NhZ2UKCiBjb21wb25lbnRzL3JhcHBvcnRsZXRz
L3NyYy9jb20vc2ljYXAvZ3VpZi9wb3J0YWxmcmFtZXdvcmsvcG9ydGxldHMvcmFwL1JlcG9y
dEZyYXVkQ0RSUXVlcmllclBvcnRsZXQuamF2YSB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKY29tbWl0IDJlZDFjOTJlZWM1
MThhNTc1MjI3N2ExNmNmMmFlYTZiZDQ4OGQ2YmUKQXV0aG9yOiByZWV2emgxIDxyZWV2emgx
PgpEYXRlOiAgIEZyaSBKdWwgMjggMDQ6NTE6MDYgMjAwNiArMDAwMAoKICAgIG5vIG1lc3Nh
Z2UKCiBjb21wb25lbnRzL3JhcHBvcnRsZXRzL3NyYy9jb20vc2ljYXAvZ3VpZi9wb3J0YWxm
cmFtZXdvcmsvcG9ydGxldHMvcmFwL0NvbW1vbkF0dHJpYnV0ZU5hbWVzLmphdmEgICAgICAg
ICB8ICAgNiArKwogY29tcG9uZW50cy9yYXBwb3J0bGV0cy9zcmMvY29tL3NpY2FwL2d1aWYv
cG9ydGFsZnJhbWV3b3JrL3BvcnRsZXRzL3JhcC9SZXBvcnRGcmF1ZENEUlF1ZXJpZXJJdGVt
LmphdmEgICAgfCAxMjkgKysrKysrKysrKysrKysrKysrKysrKysrCiBjb21wb25lbnRzL3Jh
cHBvcnRsZXRzL3NyYy9jb20vc2ljYXAvZ3VpZi9wb3J0YWxmcmFtZXdvcmsvcG9ydGxldHMv
cmFwL1JlcG9ydEZyYXVkQ0RSUXVlcmllclBvcnRsZXQuamF2YSB8IDEwMSArKysrKysrKysr
KysrKystLS0tCiBjb21wb25lbnRzL3JhcHBvcnRsZXRzL3NyYy9jb20vc2ljYXAvZ3VpZi9w
b3J0YWxmcmFtZXdvcmsvcG9ydGxldHMvcmFwL2NvbnRhaW5lcnMvUmVwb3J0Q29udGFpbmVy
LmphdmEgICB8ICA0OCArKysrKysrKysKIHJlc291cmNlcy9SZXBvcnRGcmF1ZENEUlF1ZXJp
ZXJfZW4ucHJvcGVydGllcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHdlYi9qc3AvcmVwb3J0X2ZyYXVkY2Ry
X3F1ZXJpZXIuanNwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIxICsrLS0KIHdlYi9qc3AvcmVwb3J0
X2ZyYXVkY2RyX3F1ZXJpZXJfcHJpbnQuanNwICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzA5ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogd2ViL3Jl
c291cmNlcy9MYW5ndWFnZV9lbi5wcm9wZXJ0aWVzICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKy0K
IDggZmlsZXMgY2hhbmdlZCwgNTk1IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQoK
CgoKCgoKCgpjb21taXQgZDZhNzMzNWVhMjQzMjM1MDlkZjAyYjA4ZjUyYWYwMTkyNmViNWU0
ZApBdXRob3I6IHJlZGFuZTEgPHJlZGFuZTE+CkRhdGU6ICAgVGh1IEp1bCA2IDEwOjI4OjI0
IDIwMDYgKzAwMDAKCiAgICBubyBtZXNzYWdlCgouLi4K
------------1089522C21CF43EE
Content-Type: TEXT/PLAIN;
 name="cvsps3.txt"
Content-transfer-encoding: base64
Content-Disposition: attachment;
 filename="cvsps3.txt"

Y3ZzcHMzOgoKY29tbWl0IGQzNzMyZGJkZjQxYjM0OGYwMDUwZTg4ODczM2NlMmFmZWMwNWY3
ZjgKQXV0aG9yOiByZWV2emgxIDxyZWV2emgxPgpEYXRlOiAgIEZyaSBKdWwgMjggMTA6NDc6
MTcgMjAwNiArMDAwMAoKICAgIG5vIG1lc3NhZ2UKCiBjb21wb25lbnRzL3JhcHBvcnRsZXRz
L3NyYy9jb20vc2ljYXAvZ3VpZi9wb3J0YWxmcmFtZXdvcmsvcG9ydGxldHMvcmFwL1JlcG9y
dEZyYXVkQ0RSUXVlcmllclBvcnRsZXQuamF2YSB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKY29tbWl0IDE1OGJjNTVhZmZh
ODBiNjA0NzFlYTYwMjZiMTM5MzkzNGY5MjhlNTgKQXV0aG9yOiByZWV2emgxIDxyZWV2emgx
PgpEYXRlOiAgIEZyaSBKdWwgMjggMDQ6NTE6MjIgMjAwNiArMDAwMAoKICAgIG5vIG1lc3Nh
Z2UKCiBjb21wb25lbnRzL3JhcHBvcnRsZXRzL3NyYy9jb20vc2ljYXAvZ3VpZi9wb3J0YWxm
cmFtZXdvcmsvcG9ydGxldHMvcmFwL1JlcG9ydEZyYXVkQ0RSUXVlcmllckl0ZW0uamF2YSAg
fCAxMjkgKysrKysrKysrKysrKysrKysrKysrKysrKwogY29tcG9uZW50cy9yYXBwb3J0bGV0
cy9zcmMvY29tL3NpY2FwL2d1aWYvcG9ydGFsZnJhbWV3b3JrL3BvcnRsZXRzL3JhcC9jb250
YWluZXJzL1JlcG9ydENvbnRhaW5lci5qYXZhIHwgIDQ4ICsrKysrKysrKysKIHdlYi9qc3Av
cmVwb3J0X2ZyYXVkY2RyX3F1ZXJpZXJfcHJpbnQuanNwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDMwOSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
d2ViL3Jlc291cmNlcy9MYW5ndWFnZV9lbi5wcm9wZXJ0aWVzICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4
ICstCiA0IGZpbGVzIGNoYW5nZWQsIDQ5MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cgpjb21taXQgMWJhOTBhMmJhZWJlZTlmMTgzOGRhYjA0ZjEyOWM3NzA0MzMxZTBhOApBdXRo
b3I6IHJlZXZ6aDEgPHJlZXZ6aDE+CkRhdGU6ICAgRnJpIEp1bCAyOCAwNDo1MTowNiAyMDA2
ICswMDAwCgogICAgbm8gbWVzc2FnZQoKIGNvbXBvbmVudHMvcmFwcG9ydGxldHMvc3JjL2Nv
bS9zaWNhcC9ndWlmL3BvcnRhbGZyYW1ld29yay9wb3J0bGV0cy9yYXAvQ29tbW9uQXR0cmli
dXRlTmFtZXMuamF2YSAgICAgICAgIHwgICA2ICsrKysKIGNvbXBvbmVudHMvcmFwcG9ydGxl
dHMvc3JjL2NvbS9zaWNhcC9ndWlmL3BvcnRhbGZyYW1ld29yay9wb3J0bGV0cy9yYXAvUmVw
b3J0RnJhdWRDRFJRdWVyaWVyUG9ydGxldC5qYXZhIHwgMTAxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogcmVzb3VyY2VzL1Jl
cG9ydEZyYXVkQ0RSUXVlcmllcl9lbi5wcm9wZXJ0aWVzICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKysKIHdlYi9q
c3AvcmVwb3J0X2ZyYXVkY2RyX3F1ZXJpZXIuanNwICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIxICsr
KysrKysrLS0tLQogNCBmaWxlcyBjaGFuZ2VkLCAxMDIgaW5zZXJ0aW9ucygrKSwgMjggZGVs
ZXRpb25zKC0pCgpjb21taXQgZDZhNzMzNWVhMjQzMjM1MDlkZjAyYjA4ZjUyYWYwMTkyNmVi
NWU0ZApBdXRob3I6IHJlZGFuZTEgPHJlZGFuZTE+CkRhdGU6ICAgVGh1IEp1bCA2IDEwOjI4
OjI0IDIwMDYgKzAwMDAKCiAgICBubyBtZXNzYWdlCgouLi4K
------------1089522C21CF43EE--

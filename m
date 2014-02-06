From: Francis Stephens <francisstephens@gmail.com>
Subject: Confusing git log --- First time bug submission please advise on best practices
Date: Thu, 6 Feb 2014 14:02:09 +0000
Message-ID: <CAJaBJzJeeEKpaTVXv+LnZd49xjnDjU25y9i_3kKNOrRPVbP-wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ab97ac1c54804f1bd5108
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 15:02:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBPXE-0000kz-1x
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 15:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbaBFOC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 09:02:27 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:38140 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbaBFOC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 09:02:26 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so3094095qcq.22
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Y/n9hKbMxAVc7T0zMdbSQGOUIJIWXvjMK8g5RAngRrk=;
        b=SB8lDoNIhepOydGhenKzsjYzCpPgM9FutOvjihV+U30e3t78JWJFxjEPL7eOId1Hha
         qQI8J3vPVg7+OZqz0DAwK3G5Os59CWrjGqn7c+nkFua074wnr/xuiH5HPa+da+a1sDnq
         s/HlNNCEDxytxq5WVecT6CJnTmupvs2l55NlG//E/gjcZ9ke37Bbjy3JJ9WbWS24h7Jm
         ZBLw9SewvMhRXj+nQiaCoxjbQLfqTr0C22UWe7Dx+TM/4uVnnuDojz6KTs2XNu92DcA9
         p8iS30f7Hk5oymwvGYKLHN31SX5B5ek3NbBp1DBnD1dpEN9iVAakhMOP03Cji7ktmnxw
         uATw==
X-Received: by 10.140.92.54 with SMTP id a51mr7508954qge.111.1391695329540;
 Thu, 06 Feb 2014 06:02:09 -0800 (PST)
Received: by 10.140.35.211 with HTTP; Thu, 6 Feb 2014 06:02:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241693>

--001a113ab97ac1c54804f1bd5108
Content-Type: text/plain; charset=ISO-8859-1

My co-worker has an inconsistent git log output. Please see that
attached files for output (I've made a best effort to remove
confidential info from them).

Comparing the two log commands we can see that master and
originssh/master have a shared common commit at

    <John Doe> (4 hours ago) d85832d
  More pom fixes

The top commit for originssh/master and the second to top for master.

I would expect that both logs would share an _identical_ history from
that commit onward. But the log for master contains the following

  <Jeremy Doe> (27 hours ago) 239ea21  (my-work)
  renamed class

  <Jeremy Doe> (28 hours ago) 27750b2
  Merge branch 'master' of
http://githost.companyname-dev.local/trading-development/sports-container-framework

and

  <Jeremy Doe> (2 days ago) a933acb
  white space changes

  <Jeremy Doe> (2 days ago) b5e51e7
  Merge branch 'master' of
http://githost.companyname-dev.local/trading-development/sports-container-framework

  <Jeremy Doe> (2 days ago) 3a0f787
  removed public methods

  <Jeremy Doe> (2 days ago) 4e91130
  added the xml deserialisation

None of which appear in the originssh/master log. Is there a scenario
in which this is expected. It was my understanding that any two
commits with the same hash have exactly the same history.

Thanks for your time.





Technical details:

He is using the Windows git client version 1.8.5.2.msysgit.0
Running on Windows 7
Every command was run through git bash

Background:

He previously had tortoise-git installed, but I had him uninstall it
to solve some ssh problems
While uninstalling tortoise-git we also reinstalled git - I don't know
what the previous version of git was.

Output of

    git branch -avv
    * master                   6833fd4 Completed merge
      my-work                  239ea21 renamed class
      remotes/origin/HEAD      -> origin/master
      remotes/origin/master    f269789 Cleaning up GIT step 1
      remotes/originssh/master d85832d More pom fixes

The background on the originssh remote branch is that his origin uses
an HTTP url which wasn't allowing him to push a large commit. I helped
him to create originssh to allow the push to be made.

--001a113ab97ac1c54804f1bd5108
Content-Type: application/octet-stream; name=master
Content-Disposition: attachment; filename=master
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hrc3ajpk0

Z2l0IGxnIG1hc3RlcgoKPEplcmVteSBEb2U+ICgyIGhvdXJzIGFnbykgNjgzM2ZkNCAgKEhFQUQs
IG1hc3RlcikKCkNvbXBsZXRlZCBtZXJnZQoKCgo8Sm9obiBEb2U+ICg0IGhvdXJzIGFnbykgZDg1
ODMyZCAgKG9yaWdpbnNzaC9tYXN0ZXIpCgpNb3JlIHBvbSBmaXhlcwoKCgo8Sm9obiBEb2U+ICgy
MCBob3VycyBhZ28pIDM5ZjNlODcgCgpmZXcgcG9tIGZpeGVzIHNvIHByb2plY3QgY2FuIGJ1aWxk
IGluIG5leHVzCgoKCjxKb2huIERvZT4gKDIwIGhvdXJzIGFnbykgZjNjZDdhZCAKCmZpeGVkIGEg
ZmV3IGJ1Z3MgdGhhdCB3YXMgc3RvcHBpbmcgaXQgZnJvbSBidWlsZGluZwoKCgo8Sm9obiBEb2U+
ICgyMSBob3VycyBhZ28pIDc4MmZiMWMgCgp1cGRhdGVkIGthbmdhcm9vYm94aW5nLXJuZCBtb2R1
bGUKCgoKPEpvaG4gRG9lPiAoMjEgaG91cnMgYWdvKSA5M2I1NmQzIAoKLmdpdGlnbm9yZSBmaWxl
IHRvIGlnbm9yZSAuaW1sIGFuZCAuaWRlYSBmaWxlcwoKCgo8Sm9obiBEb2U+ICgyMSBob3VycyBh
Z28pIDlkZWMyZGYgCgpVcGRhdGVkIGNvZGUgZm9yIGNyZWF0aW9uIGluY2wuIHVuaXQgdGVzdHMK
CgoKPEphbmUgRG9lPiAoMjIgaG91cnMgYWdvKSA4ZjRiYTE1IAoKQWRkZWQgbWFya2V0IG1vZGVs
CgoKCjxKZXJlbXkgRG9lPiAoMjcgaG91cnMgYWdvKSAyMzllYTIxICAobXktd29yaykKCnJlbmFt
ZWQgY2xhc3MKCgoKPEplcmVteSBEb2U+ICgyOCBob3VycyBhZ28pIDI3NzUwYjIgCgpNZXJnZSBi
cmFuY2ggJ21hc3Rlcicgb2YgaHR0cDovL2dpdGhvc3QuY29tcGFueW5hbWUtZGV2LmxvY2FsL3Ry
YWRpbmctZGV2ZWxvcG1lbnQvc3BvcnRzLWNvbnRhaW5lci1mcmFtZXdvcmsKCgoKPEphbmUgRG9l
PiAoMiBkYXlzIGFnbykgZjI2OTc4OSAgKG9yaWdpbi9tYXN0ZXIsIG9yaWdpbi9IRUFEKQoKQ2xl
YW5pbmcgdXAgR0lUIHN0ZXAgMQoKCgo8SmVyZW15IERvZT4gKDIgZGF5cyBhZ28pIGE5MzNhY2Ig
Cgp3aGl0ZSBzcGFjZSBjaGFuZ2VzCgoKCjxKZXJlbXkgRG9lPiAoMiBkYXlzIGFnbykgYjVlNTFl
NyAKCk1lcmdlIGJyYW5jaCAnbWFzdGVyJyBvZiBodHRwOi8vZ2l0aG9zdC5jb21wYW55bmFtZS1k
ZXYubG9jYWwvdHJhZGluZy1kZXZlbG9wbWVudC9zcG9ydHMtY29udGFpbmVyLWZyYW1ld29yawoK
Cgo8SmVyZW15IERvZT4gKDIgZGF5cyBhZ28pIDNhMGY3ODcgCgpyZW1vdmVkIHB1YmxpYyBtZXRo
b2RzCgoKCjxKZXJlbXkgRG9lPiAoMiBkYXlzIGFnbykgNGU5MTEzMCAKCmFkZGVkIHRoZSB4bWwg
ZGVzZXJpYWxpc2F0aW9uCgoKCjxKb2huIERvZT4gKDIgZGF5cyBhZ28pIGUxMGU4NzcgCgpNZXJn
ZWQgY3JlYXRpb24gdG8gT3BlbmJldCBjb2RlIHdpdGggSmFuZSdzIG5ld2VzdCBjb2RlCgo=
--001a113ab97ac1c54804f1bd5108
Content-Type: application/octet-stream; name=originssh_master
Content-Disposition: attachment; filename=originssh_master
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hrc3ajqb1

Z2l0IGxnIG9yaWdpbnNzaC9tYXN0ZXIKCjxKb2huIERvZT4gKDQgaG91cnMgYWdvKSBkODU4MzJk
ICAob3JpZ2luc3NoL21hc3RlcikKCk1vcmUgcG9tIGZpeGVzCgoKCjxKb2huIERvZT4gKDIwIGhv
dXJzIGFnbykgMzlmM2U4NyAKCmZldyBwb20gZml4ZXMgc28gcHJvamVjdCBjYW4gYnVpbGQgaW4g
bmV4dXMKCgoKPEpvaG4gRG9lPiAoMjAgaG91cnMgYWdvKSBmM2NkN2FkIAoKZml4ZWQgYSBmZXcg
YnVncyB0aGF0IHdhcyBzdG9wcGluZyBpdCBmcm9tIGJ1aWxkaW5nCgoKCjxKb2huIERvZT4gKDIx
IGhvdXJzIGFnbykgNzgyZmIxYyAKCnVwZGF0ZWQga2FuZ2Fyb29ib3hpbmctcm5kIG1vZHVsZQoK
Cgo8Sm9obiBEb2U+ICgyMSBob3VycyBhZ28pIDkzYjU2ZDMgCgouZ2l0aWdub3JlIGZpbGUgdG8g
aWdub3JlIC5pbWwgYW5kIC5pZGVhIGZpbGVzCgoKCjxKb2huIERvZT4gKDIxIGhvdXJzIGFnbykg
OWRlYzJkZiAKClVwZGF0ZWQgY29kZSBmb3IgY3JlYXRpb24gaW5jbC4gdW5pdCB0ZXN0cwoKCgo8
SmFuZSBEb2U+ICgyMiBob3VycyBhZ28pIDhmNGJhMTUgCgpBZGRlZCBtYXJrZXQgbW9kZWwKCgoK
PEphbmUgRG9lPiAoMiBkYXlzIGFnbykgZjI2OTc4OSAgKG9yaWdpbi9tYXN0ZXIsIG9yaWdpbi9I
RUFEKQoKQ2xlYW5pbmcgdXAgR0lUIHN0ZXAgMQoKCgo8Sm9obiBEb2U+ICgyIGRheXMgYWdvKSBl
MTBlODc3IAoKTWVyZ2VkIGNyZWF0aW9uIHRvIE9wZW5iZXQgY29kZSB3aXRoIEphbmUncyBuZXdl
c3QgY29kZQo=
--001a113ab97ac1c54804f1bd5108--

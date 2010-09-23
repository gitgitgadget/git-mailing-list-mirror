From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made) (was ANNOUNCE
 git-what-branch)
Date: Thu, 23 Sep 2010 23:32:07 +0200
Message-ID: <4C9BC757.3050803@gmail.com>
References: <201009222326.o8MNQJ2E022410@no.baka.org>	<32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com> <AANLkTinw2bWWYD7UcS8P=uDJm8p3TGuWA133+BsnZPGH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Bash <bash@genarts.com>,
	Seth Robertson <in-gitvger@baka.org>,
	Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 23:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OytOv-0002Ff-RY
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab0IWVcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 17:32:15 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49544 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab0IWVcN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 17:32:13 -0400
Received: by eyb6 with SMTP id 6so595688eyb.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=8V3qfLydk6pdUgzZ1fQJMD5YQlw1nmSXrY3AWPvHC3w=;
        b=Ts+EZqWHoXT8oY5vpy/Qfa9OzA2RORAjIdX/VeyG58dKTmD3uVVeXEXZ/F7A1yFc6N
         FDIu7Lg28+GEd9gyva27tDCTG4Fgmzx1WI0hntuRe4Xtxctxv6Zthoas4czmTZwKh49D
         Gn+q/1Idt+UAV7hACBj1CMod4leeX19+xVOVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=uXGLxpwKeg+ZTdjw4MMKrd8/Cu5YZjPq5p+khgi839Uv3zrwg6ZJY0lpaK0nDsiuIv
         PvlF02FdKEs0sWOsE1gydL9Yrwi7sK4SjHxw7oC97iHzdYjVUDAbm3x7HoN19AP7gRwT
         3Dz8BLrSylmc+IY1zW17XSjUwuuniEWyLfcBQ=
Received: by 10.213.97.129 with SMTP id l1mr6958767ebn.56.1285277532384;
        Thu, 23 Sep 2010 14:32:12 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-126-58.multimo.pl [89.174.126.58])
        by mx.google.com with ESMTPS id v8sm1901986eeh.8.2010.09.23.14.32.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 14:32:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <AANLkTinw2bWWYD7UcS8P=uDJm8p3TGuWA133+BsnZPGH@mail.gmail.com>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156917>

On 09/23/10 15:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Sep 23, 2010 at 13:14, Stephen Bash <bash@genarts.com> wrote:
>>> From: "Seth Robertson" <in-gitvger@baka.org>
>>> ... I wanted something completely different. Something more
>>> like: if a bug was introduced in commit X, what releases or branche=
s
>>> has it contaminated (or more positively, if a feature was introduce=
d,
>>> where was it made available). The simple case is figuring out on
>>> which branch a commit was originally made.
>=20
>> Wait... When you restate the problem that way, isn't
>> git-{branch,tag} --contains the right answer?  I'm curious how you
>> (and others) would differentiate the approaches...
>=20
> git-{branch,tag} *is* the right answer, the problem here was that the
> original reporter wanted to *delete* the original branch, or otherwis=
e
> not make it available, but still find out what it was.
>=20
> The workaround is to walk the tree from a merge commit, but I think a
> better solution is to just push the refs to your topic branches
> somewhere and keep them in an archive/ namespace. Then if you need to
> go digging you can always add the archive as a remote and go
> git-{branch,tag} --contains.

While this was my initial suggestion too, there are several valid reaso=
ns
for wanting such functionality. One is obviously to ease adaptation for=
=20
users switching from other vcses, where branches are much more "special=
".
Another is that maintaining fine enough granularity in tag/branch namin=
g
may not be that easy, not to mention the namespace clutter that causes =
and
that large scale omissions are practically impossible to fix retroactiv=
ely.

But that's not all, consider:

$ time git-show-merge-path 0c357544b0d `git for-each-ref refs/remotes/o=
rigin --format=3D'%(refname)'| sed -e 's,refs/remotes/,,'`
f88bdb1c315a M: 'ab/test' =3D> next                                    =
 100818 21:07
# Merged into origin/next
a2c6726417db M: 'ab/test-2'                                           1=
00904 15:15
# Merged into origin/master, origin/HEAD and origin/pu
# Not reachable from origin/html, origin/man, origin/maint and origin/t=
odo
0m0.333s user   0m0.010s system   0m0.355s elapsed   96.82% CPU

$ time git branch -r --contains 0c357544b0d
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/next
  remotes/origin/pu
0m0.283s user   0m0.013s system   0m0.303s elapsed   97.84% CPU
$

both commands have approximately the same cost, except the first one gi=
ves you
much more information.

Or, using the kernel repo: [1]

$ time git-show-merge-path 86ab04c8c1df51df master release =20
b1bc81a0ef86 M: 'master'@$KO/linville/wireless-next-2.6               0=
90607 11:24
36432dae73cf M: 'master'@$KO/davem/net-next-2.6                       0=
90611 14:00
2ed0e21b30b5 M: $KO/davem/net-next-2.6                                0=
90615 16:40
# Merged into release and master
0m3.056s user   0m0.207s system   0m3.154s elapsed   103.46% CPU
$

Script below; w/ one or two args works like the previous git-find-branc=
h-for,
except it's ~two times faster for expensive queries and does that silly=
 five=20
old branch request in <13s, for *all* 150 heads; <10s for master alone;=
 also
this one won't show extra merges that happened after the commit arrived=
 on the
branch. When ran w/ more then one branch name, will print the merge poi=
nts
and/or unreachability info for all of them, as in the above git.git exa=
mple.

There's still a bug in there somewhere; finding it before blindly trans=
forming
it into perl might be a good idea ;) I'll fix it when i'll encounter it=
 in .rl,
right now i don't remember the random commit (in git.git) which confuse=
d it...
Still no ff-detection, mostly due to lack of (real) test case.

artur

[1] yes, 36432dae73cf could be omitted, but i can't convince myself tha=
t it
/should/ be. Implementing the filtering would be simple and cheap, but =
i think
i want to know that another path to master exists.


-----------------------------------------------------------------------=
----------
#! /usr/bin/env pike
// git-show-merge-path <rev> [long-lived-branch(es)]
// v. 0.99
// Will show all external merge commits starting at <rev> until
// this commit appears on the specified branches. When that happens
// "# Merged into <branchlist>" is printed. If <rev> is still
// unreachable from some of the branches then the search continues.
// If at least one of the branches does not contain <rev> then $0
// can and will print *all* merges (ie it won't stop at the last
// of the given branches containing this commit), followed by=20
// "# Not reachable from <branchlist>". This is a feature (can be
// used to find leaks outside of the given branches).
//
#define die(a...) exit(1, "Aborting; %s"+a)

string run(string ... cmdline) {
#if __REAL_MAJOR__<7 || __REAL_MAJOR__=3D=3D7 && __REAL_MINOR__<8
   string s =3D Process.popen(cmdline*" ");
   if (s=3D=3D"")
      die("\n", cmdline*" ");
   return s;
#else
   mapping r;
   mixed e =3D catch { r =3D Process.run( ({@cmdline}) ); };
   if (e || r["exitcode"])
      die("", e?e:r["stderr"]);
   return r["stdout"];
#endif
}

static mapping commits =3D ([]);

array parsecommits(string ... delim) {
   array res =3D ({});
   string id;
   array lines =3D run("git", "rev-list", "--format=3Draw",  "--ancestr=
y-path",
                                        "--topo-order", @delim)/"\n";
   mapping branchkids =3D ([]);
   foreach (lines, string line) {
      array words =3D line/" ";
      string h =3D words[0];
      if (h=3D=3D"commit") {
         id =3D words[1];
	 commits[id] =3D ([]);
	 res +=3D ({id});
	 if (mapping bs =3D m_delete(branchkids, id))
	    commits[id]["Branch"] +=3D bs;
	 if (mapping bs =3D livebranches[id])
	    commits[id]["Branch"] +=3D bs;
      } else if (h=3D=3D"") {
         if (commits[id])
            commits[id][""] +=3D ({line});
      }
      else {
         if (h=3D=3D"parent" && !commits[id]["parent"] && commits[id]["=
Branch"]) {
            if (branchkids[words[1]])
               branchkids[words[1]] +=3D commits[id]["Branch"];
	    else
               branchkids[words[1]] =3D commits[id]["Branch"];
         }
         commits[id][h] +=3D words[1..];
      }
   }
   return res;
}

static mapping desc =3D ([]);

static mapping livebranches =3D ([]); // id : array(name)
static mapping branchnames =3D ([]);  // name : void

int main(int argc, array argv) {
   argv[1] =3D (run("git", "rev-parse", argv[1])/"\n")[0];
   if (argc=3D=3D2)
      argv +=3D ({"master"});
   for (int i=3D2; i<sizeof(argv); i++) {
      string ref =3D argv[i];
      string refid =3D (run("git", "rev-parse", argv[i])/"\n")[0];
      livebranches[refid] +=3D ([ ref : refid ]);
      branchnames[ref] =3D refid;
      argv[i] =3D refid;
   }
   array commit_list =3D parsecommits("^"+argv[1], @argv[2..]);
   commit_list =3D reverse(commit_list);
   desc[argv[1]] =3D 1;
   foreach (commit_list, string id) {
      if (commits[id]["parent"]) {
         foreach (commits[id]["parent"], string parent)
            if (desc[parent])
        	desc[id] =3D 1;
	 if (sizeof(commits[id]["parent"])>1)
            if (!desc[commits[id]["parent"][0]]) {
	       mapping reached =3D ([]);
	       if (commits[id]["Branch"])
	          reached =3D commits[id]["Branch"]&branchnames;
	       int comtime =3D (int)commits[id]["committer"][-2];
               write("%.12s %-56.56s %.12s\n", id,=20
	              squeeze_subject(commits[id][""][1]),
		      cal->Second(comtime)->format_time_xshort() );
               if (sizeof(reached)>0) {
	          branchnames -=3D reached;
                  write("# Merged into %s\n",=20
		          String.implode_nicely(indices(reached)) );
		  if (sizeof(branchnames)=3D=3D0)
		     exit(0);
	       }
	    }
      }
      m_delete(commits, id);
   }
   write("# Not reachable from %s\n",  String.implode_nicely(indices(br=
anchnames)) );
}

string squeeze_subject(string subject) {

   subject =3D String.trim_all_whites(subject);
   subject =3D String.expand_tabs(subject);
   foreach (sub_from_to, mapping m)
      subject =3D replace(subject, m);
   return subject;
}

static array(mapping) sub_from_to =3D
({
   ([=20
      "Merge branch " : "Merge ",
      "Merge remote branch " : "Merge ",
      "Merge branches " : "MM:",
   ]),
   ([=20
      "Merge " : "M: ",
      "' of git:": "'@git:",
      "' into ": "' =3D> ",
   ]),
   ([=20
       "git://git.kernel.org/pub/scm/linux/kernel/git/" : "$KO/",
       "commit '" : "C'"
   ]),
});

static object cal =3D Calendar.ISO.set_timezone(Calendar.Timezone.UTC);

-----------------------------------------------------------------------=
----------

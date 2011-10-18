From: "L. A. Linden Levy" <alevy@mobitv.com>
Subject: Re: git-p4.skipSubmitEdit
Date: Tue, 18 Oct 2011 09:51:24 -0700
Organization: MobiTV
Message-ID: <1318956684.2717.7.camel@uncle-pecos>
References: <1315514452.10046.0.camel@uncle-pecos>
	 <4E6DB5F0.7080303@diamand.org> <1315847540.10046.29.camel@uncle-pecos>
	 <20111018004500.GA31768@arf.padd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-RZMWrvvH8sOQdynlDN1C"
Cc: Luke Diamand <luke@diamand.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 19:03:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGD4P-0005Gr-Nb
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 19:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab1JRRDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 13:03:13 -0400
Received: from mxout.myoutlookonline.com ([64.95.72.241]:9900 "EHLO
	mxout.myoutlookonline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab1JRRDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 13:03:12 -0400
X-Greylist: delayed 658 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Oct 2011 13:03:11 EDT
Received: from mxout.myoutlookonline.com (localhost [127.0.0.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id ED7148BEB4C;
	Tue, 18 Oct 2011 12:52:12 -0400 (EDT)
X-Virus-Scanned: by SpamTitan at mail.lan
Received: from mx1.myoutlookonline.com (unknown [10.110.2.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id 22C9C8BEAB0;
	Tue, 18 Oct 2011 12:52:12 -0400 (EDT)
Received: from mx1.myoutlookonline.com ([10.9.36.14]) by mx1.myoutlookonline.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Oct 2011 12:52:09 -0400
Received: from [172.16.131.153] ([75.55.199.5]) by mx1.myoutlookonline.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Oct 2011 12:52:10 -0400
In-Reply-To: <20111018004500.GA31768@arf.padd.com>
X-Mailer: Evolution 3.2.0- 
X-OriginalArrivalTime: 18 Oct 2011 16:52:10.0917 (UTC) FILETIME=[4772C550:01CC8DB6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183888>


--=-RZMWrvvH8sOQdynlDN1C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

This is just fine for me. Like I said initially I did not approach the
problem from an engineering perspective, I just changed it to prevent
the patch questions so I could commit faster. Looking forward to seeing
the update in the repo.

Cheers,
Alex

On Mon, 2011-10-17 at 20:45 -0400, Pete Wyckoff wrote:
> alevy@mobitv.com wrote on Mon, 12 Sep 2011 10:12 -0700:
> > I agree with almost all your points. I have answered them each in-line
> > below.
> >=20
> > On Mon, 2011-09-12 at 03:34 -0400, Luke Diamand wrote:
> > > On 08/09/11 21:40, L. A. Linden Levy wrote:
> > > > Hi All,
> > > >
> > > > I have been using git-p4 for a while and it has allowed me to compl=
etely
> > > > change the way I develop and still be able to use perforce which my
> > > > company has for its main VCS. One thing that was driving me nuts wa=
s
> > > > that "git p4 submit" cycles through all of my individual commits an=
d
> > > > asks me if I want to change them. The way I develop I often am chec=
king
> > > > in 20 to 50 different small commits each with a descriptive git com=
ment.
> > > > I felt like I was doing double duty by having emacs open on every c=
ommit
> > > > into perforce. So I modified git-p4 to have an option to skip the
> > > > editor. This option coupled with git-p4.skipSubmitEditCheck will ma=
ke
> > > > the submission non-interactive for "git p4 submit".
> > >=20
> > >=20
> > > Sorry - I've not had a chance to look at this before now. But a coupl=
e=20
> > > of comments:
> > >=20
> > >   - Is there a line wrap problem in the patch? It doesn't seem to wan=
t=20
> > > to apply for me.
> >=20
> > Probably. Below are the results from following the patch submission
> > instructions.=20
>=20
> Sorry I sat on this for a month.  It is a good idea.  Your
> patches were good in content, but they didn't apply well due to
> being line-wrapped and having one duplicate.
>=20
> Reading the code, though, I decided that the whole
> skipSubmitEdit* checking was a bit convoluted even before you got
> to it.  So I moved it all to a separate function.  And added a
> unit test.
>=20
> Tell me if you think this is okay instead.  If I got a bit too
> wordy in the doc, please help with that too.
>=20
> 		-- Pete
>=20
> --- 8< ---
>=20
> Subject: [PATCH] git-p4: introduce skipSubmitEdit
>=20
> Add a configuration variable to skip invoking the editor in the
> submit path.
>=20
> The existing variable skipSubmitEditCheck continues to make sure
> that the submit template was indeed modified by the editor; but,
> it is not considered is skipSubmitEdit is true.
>=20
> Reported-by: Loren A. Linden Levy <lindenle@gmail.com>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  contrib/fast-import/git-p4     |   60 +++++++++++++++++++----------
>  contrib/fast-import/git-p4.txt |   19 ++++++++-
>  t/t9804-skip-submit-edit.sh    |   82 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 137 insertions(+), 24 deletions(-)
>  create mode 100755 t/t9804-skip-submit-edit.sh
>=20
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index f885d70..abd6778 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -847,6 +847,39 @@ class P4Submit(Command, P4UserMap):
> =20
>          return template
> =20
> +    def edit_template(self, template_file):
> +        """Invoke the editor to let the user change the submission
> +           message.  Return true if okay to continue with the submit."""
> +
> +        # if configured to skip the editing part, just submit
> +        if gitConfig("git-p4.skipSubmitEdit") =3D=3D "true":
> +            return True
> +
> +        # look at the modification time, to check later if the user save=
d
> +        # the file
> +        mtime =3D os.stat(template_file).st_mtime
> +
> +        # invoke the editor
> +        if os.environ.has_key("P4EDITOR"):
> +            editor =3D os.environ.get("P4EDITOR")
> +        else:
> +            editor =3D read_pipe("git var GIT_EDITOR").strip()
> +        system(editor + " " + template_file)
> +
> +        # If the file was not saved, prompt to see if this patch should
> +        # be skipped.  But skip this verification step if configured so.
> +        if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
> +            print "return true for skipSubmitEditCheck"
> +            return True
> +
> +        if os.stat(template_file).st_mtime <=3D mtime:
> +            while True:
> +                response =3D raw_input("Submit template unchanged. Submi=
t anyway? [y]es, [n]o (skip this patch) ")
> +                if response =3D=3D 'y':
> +                    return True
> +                if response =3D=3D 'n':
> +                    return False
> +
>      def applyCommit(self, id):
>          print "Applying %s" % (read_pipe("git log --max-count=3D1 --pret=
ty=3Doneline %s" % id))
> =20
> @@ -1001,7 +1034,7 @@ class P4Submit(Command, P4UserMap):
> =20
>              separatorLine =3D "######## everything below this line is ju=
st the diff #######\n"
> =20
> -            [handle, fileName] =3D tempfile.mkstemp()
> +            (handle, fileName) =3D tempfile.mkstemp()
>              tmpFile =3D os.fdopen(handle, "w+")
>              if self.isWindows:
>                  submitTemplate =3D submitTemplate.replace("\n", "\r\n")
> @@ -1009,25 +1042,9 @@ class P4Submit(Command, P4UserMap):
>                  newdiff =3D newdiff.replace("\n", "\r\n")
>              tmpFile.write(submitTemplate + separatorLine + diff + newdif=
f)
>              tmpFile.close()
> -            mtime =3D os.stat(fileName).st_mtime
> -            if os.environ.has_key("P4EDITOR"):
> -                editor =3D os.environ.get("P4EDITOR")
> -            else:
> -                editor =3D read_pipe("git var GIT_EDITOR").strip()
> -            system(editor + " " + fileName)
> =20
> -            if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
> -                checkModTime =3D False
> -            else:
> -                checkModTime =3D True
> -
> -            response =3D "y"
> -            if checkModTime and (os.stat(fileName).st_mtime <=3D mtime):
> -                response =3D "x"
> -                while response !=3D "y" and response !=3D "n":
> -                    response =3D raw_input("Submit template unchanged. S=
ubmit anyway? [y]es, [n]o (skip this patch) ")
> -
> -            if response =3D=3D "y":
> +            if self.edit_template(fileName):
> +                # read the edited message and submit
>                  tmpFile =3D open(fileName, "rb")
>                  message =3D tmpFile.read()
>                  tmpFile.close()
> @@ -1039,11 +1056,12 @@ class P4Submit(Command, P4UserMap):
>                  if self.preserveUser:
>                      if p4User:
>                          # Get last changelist number. Cannot easily get =
it from
> -                        # the submit command output as the output is unm=
arshalled.
> +                        # the submit command output as the output is
> +                        # unmarshalled.
>                          changelist =3D self.lastP4Changelist()
>                          self.modifyChangelistUser(changelist, p4User)
> -
>              else:
> +                # skip this patch
>                  for f in editedFiles:
>                      p4_revert(f)
>                  for f in filesToAdd:
> diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.=
txt
> index 52003ae..5044a12 100644
> --- a/contrib/fast-import/git-p4.txt
> +++ b/contrib/fast-import/git-p4.txt
> @@ -202,11 +202,24 @@ able to find the relevant client.  This client spec=
 will be used to
>  both filter the files cloned by git and set the directory layout as
>  specified in the client (this implies --keep-path style semantics).
> =20
> -git-p4.skipSubmitModTimeCheck
> +git-p4.skipSubmitEdit
> =20
> -  git config [--global] git-p4.skipSubmitModTimeCheck false
> +  git config [--global] git-p4.skipSubmitEdit false
> =20
> -If true, submit will not check if the p4 change template has been modifi=
ed.
> +Normally, git-p4 invokes an editor after each commit is applied so
> +that you can make changes to the submit message.  Setting this
> +variable to true will skip the editing step, submitting the change as is=
.
> +
> +git-p4.skipSubmitEditCheck
> +
> +  git config [--global] git-p4.skipSubmitEditCheck false
> +
> +After the editor is invoked, git-p4 normally makes sure you saved the
> +change description, as an indication that you did indeed read it over
> +and edit it.  You can quit without saving to abort the submit (or skip
> +this change and continue).  Setting this variable to true will cause
> +git-p4 not to check if you saved the change description.  This variable
> +only matters if git-p4.skipSubmitEdit has not been set to true.
> =20
>  git-p4.preserveUser
> =20
> diff --git a/t/t9804-skip-submit-edit.sh b/t/t9804-skip-submit-edit.sh
> new file mode 100755
> index 0000000..734ccf2
> --- /dev/null
> +++ b/t/t9804-skip-submit-edit.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description=3D'git-p4 skipSubmitEdit config variables'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'init depot' '
> +	(
> +		cd "$cli" &&
> +		echo file1 >file1 &&
> +		p4 add file1 &&
> +		p4 submit -d "change 1"
> +	)
> +'
> +
> +# this works because EDITOR is set to :
> +test_expect_success 'no config, unedited, say yes' '
> +	"$GITP4" clone --dest=3D"$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		echo line >>file1 &&
> +		git commit -a -m "change 2" &&
> +		echo y | "$GITP4" submit &&
> +		p4 changes //depot/... >wc &&
> +		test_line_count =3D 2 wc
> +	)
> +'
> +
> +test_expect_success 'no config, unedited, say no' '
> +	"$GITP4" clone --dest=3D"$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		echo line >>file1 &&
> +		git commit -a -m "change 3 (not really)" &&
> +		printf "bad response\nn\n" | "$GITP4" submit
> +		p4 changes //depot/... >wc &&
> +		test_line_count =3D 2 wc
> +	)
> +'
> +
> +test_expect_success 'skipSubmitEdit' '
> +	"$GITP4" clone --dest=3D"$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git config git-p4.skipSubmitEdit true &&
> +		# will fail if editor is even invoked
> +		git config core.editor /bin/false &&
> +		echo line >>file1 &&
> +		git commit -a -m "change 3" &&
> +		"$GITP4" submit &&
> +		p4 changes //depot/... >wc &&
> +		test_line_count =3D 3 wc
> +	)
> +'
> +
> +test_expect_success 'skipSubmitEditCheck' '
> +	"$GITP4" clone --dest=3D"$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git config git-p4.skipSubmitEditCheck true &&
> +		echo line >>file1 &&
> +		git commit -a -m "change 4" &&
> +		"$GITP4" submit &&
> +		p4 changes //depot/... >wc &&
> +		test_line_count =3D 4 wc
> +	)
> +'
> +
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done

--=20
Alex Linden Levy
Senior Software Engineer
MobiTV, Inc.
6425 Christie Avenue, 5th Floor, Emeryville, CA 94608
phone 510.450.5190 mobile 720.352.8394
email alevy@mobitv.com  web www.mobitv.com


--=-RZMWrvvH8sOQdynlDN1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk6drowACgkQlZX6YS+3ZksEWQCeIUHm6X+LKuM/mav55BWFYGV+
PUYAn0/sXwhj6K9ESyyiayz3u0phQDP/
=qwsq
-----END PGP SIGNATURE-----

--=-RZMWrvvH8sOQdynlDN1C--

From: Thomas Arcila <tarcila-s5SjKpinsOs@public.gmane.org>
Subject: Re: git gui diff widget (was Re: [msysGit] Re: [cheetah]
 Questions about NOTES)
Date: Wed, 30 Jan 2008 08:58:41 +0100
Organization: Mercury Computer Systems
Message-ID: <1201679921.6348.10.camel@bod-tarcila2.ad.mc.com>
References: <ecf0120c-2bde-407d-8a4e-2f50ea7d4b54@f47g2000hsd.googlegroups.com> <alpine.LSU.1.00.0801281126350.23907@racer.site> <20080129031713.GJ24004@spearce.org> <alpine.LSU.1.00.0801291207080.23907@racer.site> <20080130040336.GN24004@spearce.org> <75E9DFB9-BE1B-4B60-921D-EE0898DFA9F3@zib.de> <20080130071304.GS24004@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HmumBa+VBEIJflyrHF5r"
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Kirill <kirillathome-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Hetro <whee-Q1H67ocemw/0qnVlFUAYEw@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Shawn O. Pearce" <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 30 08:59:26 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.187])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK7qu-0005gY-G9
	for gcvm-msysgit@m.gmane.org; Wed, 30 Jan 2008 08:59:24 +0100
Received: by ag-out-0910.google.com with SMTP id 32so559429agc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 29 Jan 2008 23:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:received:subject:from:to:cc:in-reply-to:references:content-type:organization:date:message-id:mime-version:x-mailer:x-originalarrivaltime:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=KNOya24hXuJhEvuLJcaFlXgwZs9UasNJO7uX6NG5U3o=;
        b=G5T8xzvv21ja/foj3JyT2ZwIlIhEzBiBxps4QGpcCyDaIYMCv2YZC+pLTsPENuUD9vPWUx92yGUcDAg3Xerd+umZUh4armBytBoPQ2+4KMR62wqxVAvop58CmWf9cKyfddm4Uef6DVwwjHvcdnIrm+vysbDUn1MMBNM5W/VezaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:subject:from:to:cc:in-reply-to:references:content-type:organization:date:message-id:mime-version:x-mailer:x-originalarrivaltime:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=tnbfiEFWkyzE3uIAwA6jPa1mL5A56nrPMIv2zzgTNxHearbZJazqV7raBTMM2di1XWqzUu1DpYtYZed78NmuCadlzBTpgd2Da5m87tuwhvRZX+bW6zObEbWUQoubTNDpUha1ZGqdGJSfaQb64u0Z3WErIDvAzKqk07DGdct3Hi0=
Received: by 10.101.69.10 with SMTP id w10mr440079ank.24.1201679933703;
        Tue, 29 Jan 2008 23:58:53 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1542hsa;
	Tue, 29 Jan 2008 23:58:53 -0800 (PST)
X-Sender: tarcila-s5SjKpinsOs@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.108.12 with SMTP id k12mr11899724pym.3.1201679933418; Tue, 29 Jan 2008 23:58:53 -0800 (PST)
Received: from mc.com (iris-63.mc.com [63.96.239.141]) by mx.google.com with ESMTP id x46si2831259pyg.3.2008.01.29.23.58.53; Tue, 29 Jan 2008 23:58:53 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of tarcila-s5SjKpinsOs@public.gmane.org designates 63.96.239.141 as permitted sender) client-ip=63.96.239.141;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of tarcila-s5SjKpinsOs@public.gmane.org designates 63.96.239.141 as permitted sender) smtp.mail=tarcila-s5SjKpinsOs@public.gmane.org
Received: from CHM-EMAIL2.ad.mc.com by mc.com (8.8.8+Sun/SMI-SVR4) id CAA26201; Wed, 30 Jan 2008 02:58:44 -0500 (EST)
Received: from fue-email2.ad.mc.com ([192.168.152.32]) by CHM-EMAIL2.ad.mc.com with Microsoft SMTPSVC(6.0.3790.1830); Wed, 30 Jan 2008 02:58:43 -0500
Received: from 192.168.193.115 ([192.168.193.115]) by fue-email2.ad.mc.com ([192.168.152.32]) with Microsoft Exchange Server HTTP-DAV ; Wed, 30 Jan 2008 07:58:42 +0000
Received: from bod-tarcila2 by FUE-EMAIL2; 30 Jan 2008 08:58:41 +0100
In-Reply-To: <20080130071304.GS24004-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
X-Mailer: Evolution 2.12.1
X-OriginalArrivalTime: 30 Jan 2008 07:58:43.0801 (UTC) FILETIME=[EF29B490:01C86315]
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72047>



--=-HmumBa+VBEIJflyrHF5r
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a patch to gitk that allows to run an external diff viewer.
I think it might be a suitable solution.=20
It can be configured in Edit/Preferences/External diff tool.

To see the diff between two files:
- select revisions to diff
- right click on a file in the patched files list view
- choose "External diff"

Any feedback is welcome.
Thomas

Le mercredi 30 janvier 2008 =C3=A0 02:13 -0500, Shawn O. Pearce a =C3=A9cri=
t :
> Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> wrote:
> > On Jan 30, 2008, at 5:03 AM, Shawn O. Pearce wrote:
> > >
> > >Doing a diff against a random other tree-ish, or between two random
> > >tree-ishes would be possible, but a lot more of a challenge.
> > >
> > >The diff viewer in git-gui isn't exactly a reusable widget.
> > >We'd need to refactor that so it could take patch output from any
> > >of the patch generating git commands.  Doing such is on my list
> > >of things I'd like to fix in git-gui, but I haven't had time to
> > >do it yet.
> >=20
> > Hmm, I'm not sure if such a full diff viewer is the most
> > important thing to address.  Most users (especially Windows
> > users) already have a favorite graphical diff tool and they expect
> > a mechanism to plug it into a git workflow.
>=20
> I hear this a lot from a co-worker.  He really wants a side-by-side
> diff tool in git, as he doesn't like reading patches.  Me, I've
> never been able to read a side-by-side diff tool, but I can grok
> a unified diff quite easily.  To each his own, and git should help
> users as much as it can.
> =20
> > I think a tool that presents the list of files with differences
> > and can launch an external tool for one of these files would be
> > very helpful.  I started to think about a command line version,
> > git-difftool, implementing this idea, but do not yet have code.
> > A GUI version would be preferable for cheetah anyway.  Maybe the
> > patch viewer you sketched above could provide a way to launch an
> > external tool for any of the files touched by the patch?  If the
> > widget would be reusable maybe it could also be used in gitk?
>=20
> Yea, that makes sense.  But we may want to go the other way,
> that is reuse gitk's patch viewer.  Or something.  The two tools
> (git-gui and gitk) grew their diff viewers independently, though
> I have to say that git-gui's was inspired by gitk's, and the work
> that Paul did on gitool waaaaay back when.
>=20
> Right now though I doubt there's a single line of code in common
> between them.  Hmm, I think they both use the Tk "text" widget.
> And a blue-ish color for hunk headers.  :)
>=20
>=20
> Adding a feature to git-gui to launch an external diff of that
> file against the index or HEAD shouldn't be too difficult, and I
> think is what would be most natural for the current UI.  The ugly
> part is pulling out the HEAD/index version into a temporary file
> and passing a nice -L (or something like) option to the user's diff
> viewer so they don't see the nasty temporary file name, but instead
> see a string that matches what git-gui is showing them.  And that
> option is going to differ for like every tool out there.  :-\
>=20

--=-HmumBa+VBEIJflyrHF5r
Content-Disposition: attachment; filename=0001-gitk-External-diff-viewer.patch
Content-Type: application/mbox; name=0001-gitk-External-diff-viewer.patch
Content-Transfer-Encoding: base64

RnJvbSBjYjEzYWVhMjNmZWM1M2JlYzE3NDg0ODkyN2MwNDYxZmE4MjlmMjRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgQXJjaWxhIDx0YXJjaWxhQG1jLmNvbT4KRGF0ZTog
V2VkLCAzMCBKYW4gMjAwOCAwODozODoyMiArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIGdpdGsgOiBF
eHRlcm5hbCBkaWZmIHZpZXdlci4KClJpZ2h0IGNsaWNrIG9uIHBhdGNoZWQgZmlsZSBsaXN0IHZp
ZXcgZ2l2ZXMgIkV4dGVybmFsIGRpZmYiIHBvcHVwIG1lbnUgZW50cnksCmxhdW5jaGluZyBzZWxl
Y3RlZCBleHRlcm5hbCBkaWZmIHRvb2wuCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgQXJjaWxhIDx0
YXJjaWxhQG1jLmNvbT4KLS0tCiBnaXRrIHwgIDEwOSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMSBmaWxlcyBjaGFuZ2Vk
LCAxMDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9naXRrIGIv
Z2l0awppbmRleCA1NTYwZTRkLi4wZTJjOTAyIDEwMDc1NQotLS0gYS9naXRrCisrKyBiL2dpdGsK
QEAgLTEwNTQsNiArMTA1NCwxNiBAQCBwcm9jIG1ha2V3aW5kb3cge30gewogCS1jb21tYW5kIHtm
bGlzdF9obCAwfQogICAgICRmbGlzdF9tZW51IGFkZCBjb21tYW5kIC1sYWJlbCBbbWMgIkhpZ2hs
aWdodCB0aGlzIG9ubHkiXSBcCiAJLWNvbW1hbmQge2ZsaXN0X2hsIDF9CisgICAgJGZsaXN0X21l
bnUgYWRkIGNvbW1hbmQgLWxhYmVsIFttYyAiRXh0ZXJuYWwgZGlmZiJdIFwKKyAgICAgICAgLWNv
bW1hbmQge2V4dGVybmFsX2RpZmZ9CisKKyAgICBnbG9iYWwgZmxpc3RfbWVudV90cmVlCisgICAg
c2V0IGZsaXN0X21lbnVfdHJlZSAuZmxpc3RjdHhtZW51dHJlZQorICAgIG1lbnUgJGZsaXN0X21l
bnVfdHJlZSAtdGVhcm9mZiAwCisgICAgJGZsaXN0X21lbnVfdHJlZSBhZGQgY29tbWFuZCAtbGFi
ZWwgW21jICJIaWdobGlnaHQgdGhpcyB0b28iXSBcCisJLWNvbW1hbmQge2ZsaXN0X2hsIDB9Cisg
ICAgJGZsaXN0X21lbnVfdHJlZSBhZGQgY29tbWFuZCAtbGFiZWwgW21jICJIaWdobGlnaHQgdGhp
cyBvbmx5Il0gXAorCS1jb21tYW5kIHtmbGlzdF9obCAxfQogfQogCiAjIFdpbmRvd3Mgc2VuZHMg
YWxsIG1vdXNlIHdoZWVsIGV2ZW50cyB0byB0aGUgY3VycmVudCBmb2N1c2VkIHdpbmRvdywgbm90
CkBAIC0xMTU3LDcgKzExNjcsNyBAQCBwcm9jIHNhdmVzdHVmZiB7d30gewogICAgIGdsb2JhbCBt
YXh3aWR0aCBzaG93bmVhcnRhZ3Mgc2hvd2xvY2FsY2hhbmdlcwogICAgIGdsb2JhbCB2aWV3bmFt
ZSB2aWV3ZmlsZXMgdmlld2FyZ3Mgdmlld3Blcm0gbmV4dHZpZXdudW0KICAgICBnbG9iYWwgY21p
dG1vZGUgd3JhcGNvbW1lbnQgZGF0ZXRpbWVmb3JtYXQgbGltaXRkaWZmcwotICAgIGdsb2JhbCBj
b2xvcnMgYmdjb2xvciBmZ2NvbG9yIGRpZmZjb2xvcnMgZGlmZmNvbnRleHQgc2VsZWN0Ymdjb2xv
cgorICAgIGdsb2JhbCBjb2xvcnMgYmdjb2xvciBmZ2NvbG9yIGRpZmZjb2xvcnMgZGlmZmNvbnRl
eHQgc2VsZWN0Ymdjb2xvciBleHRkaWZmdG9vbAogCiAgICAgaWYgeyRzdHVmZnNhdmVkfSByZXR1
cm4KICAgICBpZiB7IVt3aW5mbyB2aWV3YWJsZSAuXX0gcmV0dXJuCkBAIC0xMTgyLDYgKzExOTIs
NyBAQCBwcm9jIHNhdmVzdHVmZiB7d30gewogCXB1dHMgJGYgW2xpc3Qgc2V0IGRpZmZjb2xvcnMg
JGRpZmZjb2xvcnNdCiAJcHV0cyAkZiBbbGlzdCBzZXQgZGlmZmNvbnRleHQgJGRpZmZjb250ZXh0
XQogCXB1dHMgJGYgW2xpc3Qgc2V0IHNlbGVjdGJnY29sb3IgJHNlbGVjdGJnY29sb3JdCisJcHV0
cyAkZiBbbGlzdCBzZXQgZXh0ZGlmZnRvb2wgJGV4dGRpZmZ0b29sXQogCiAJcHV0cyAkZiAic2V0
IGdlb21ldHJ5KG1haW4pIFt3bSBnZW9tZXRyeSAuXSIKIAlwdXRzICRmICJzZXQgZ2VvbWV0cnko
dG9wd2lkdGgpIFt3aW5mbyB3aWR0aCAudGZdIgpAQCAtMTcxOSw3ICsxNzMwLDcgQEAgcHJvYyBz
ZWxfZmxpc3Qge3cgeCB5fSB7CiB9CiAKIHByb2MgcG9wX2ZsaXN0X21lbnUge3cgWCBZIHggeX0g
ewotICAgIGdsb2JhbCBjdGV4dCBjZmxpc3QgY21pdG1vZGUgZmxpc3RfbWVudSBmbGlzdF9tZW51
X2ZpbGUKKyAgICBnbG9iYWwgY3RleHQgY2ZsaXN0IGNtaXRtb2RlIGZsaXN0X21lbnUgZmxpc3Rf
bWVudV90cmVlIGZsaXN0X21lbnVfZmlsZQogICAgIGdsb2JhbCB0cmVlZGlmZnMgZGlmZmlkcwog
CiAgICAgc3RvcGZpbmRpbmcKQEAgLTE3MzIsNyArMTc0MywxMSBAQCBwcm9jIHBvcF9mbGlzdF9t
ZW51IHt3IFggWSB4IHl9IHsKIAlzZXQgZSBbbGluZGV4ICR0cmVlZGlmZnMoJGRpZmZpZHMpIFtl
eHByIHskbC0yfV1dCiAgICAgfQogICAgIHNldCBmbGlzdF9tZW51X2ZpbGUgJGUKLSAgICB0a19w
b3B1cCAkZmxpc3RfbWVudSAkWCAkWQorICAgIGlmIHskY21pdG1vZGUgZXEgInRyZWUifSB7Cisg
ICAgICB0a19wb3B1cCAkZmxpc3RfbWVudV90cmVlICRYICRZCisgICAgfSBlbHNlIHsKKyAgICAg
IHRrX3BvcHVwICRmbGlzdF9tZW51ICRYICRZCisgICAgfQogfQogCiBwcm9jIGZsaXN0X2hsIHtv
bmx5fSB7CkBAIC0xNzQ3LDYgKzE3NjIsNzggQEAgcHJvYyBmbGlzdF9obCB7b25seX0gewogICAg
IHNldCBnZHR0eXBlIFttYyAidG91Y2hpbmcgcGF0aHM6Il0KIH0KIAorcHJvYyBleHRlcm5hbF9k
aWZmIHt9IHsKKyAgZ2xvYmFsIGdpdGt0bXBkaXIgbnVsbGlkIG51bGxpZDIKKyAgZ2xvYmFsIGZs
aXN0X21lbnVfZmlsZQorICBnbG9iYWwgZGlmZmlkcworICBnbG9iYWwgZGlmZm51bQorICBnbG9i
YWwgZ2l0ZGlyIGV4dGRpZmZ0b29sCisKKyAgc2V0IGRpZmZpZHRvIFtsaW5kZXggJGRpZmZpZHMg
MF0KKworICBpZiB7W2xsZW5ndGggJGRpZmZpZHNdID09IDF9IHsKKyAgICAjIG5vIHJlZmVyZW5j
ZSBjb21taXQgZ2l2ZW4KKyAgICBzZXQgZGlmZmlkdG8gW2xpbmRleCAkZGlmZmlkcyAwXQorICAg
IGlmIHskZGlmZmlkdG8gZXEgJG51bGxpZCB8fCAkZGlmZmlkdG8gZXEgJG51bGxpZDJ9IHsKKyAg
ICAgICMgZGlmZmluZyB3b3JraW5nIGNvcHkgd2l0aCBIRUFECisgICAgICBzZXQgZGlmZmlkZnJv
bSAiSEVBRCIKKyAgICB9IGVsc2UgeworICAgICAgIyB1c2UgcGFyZW50IGNvbW1pdAorICAgICAg
Z2xvYmFsIGFsbHBhcmVudHMKKyAgICAgIHNldCBkaWZmaWRmcm9tICRhbGxwYXJlbnRzKCRkaWZm
aWR0bykKKyAgICB9CisgIH0gZWxzZSB7CisgICAgc2V0IGRpZmZpZGZyb20gW2xpbmRleCAkZGlm
ZmlkcyAwXQorICAgIHNldCBkaWZmaWR0byBbbGluZGV4ICRkaWZmaWRzIDFdCisgIH0KKworICBp
ZiB7ISBbaW5mbyBleGlzdHMgZGlmZm51bV19IHsKKyAgICBzZXQgZGlmZm51bSAwCisgIH0gZWxz
ZSB7CisgICAgc2V0IGRpZmZudW0gW2V4cHIgJGRpZmZudW0gKyAxXQorICB9CisKKworICBzZXQg
ZGlmZmRpciBbZmlsZSBqb2luICRnaXRrdG1wZGlyICIkZGlmZm51bSJdCisgIHNldCBkaWZmb2sg
InRydWUiCisKKyAgZmlsZSBta2RpciAkZGlmZmRpcgorICBpZiB7JGRpZmZpZHRvIGVxICRudWxs
aWQgfHwgJGRpZmZpZHRvIGVxICRudWxsaWQyfSB7CisgICAgc2V0IGRpZmZ0b2ZpbGUgW2ZpbGUg
am9pbiAkZ2l0ZGlyICIuLiIgJGZsaXN0X21lbnVfZmlsZV0KKyAgfSB7CisgICAgc2V0IGRpZmZ0
b2ZpbGUgW2ZpbGUgam9pbiAkZGlmZmRpciAiXFskZGlmZmlkdG9cXSBbZmlsZSB0YWlsICRmbGlz
dF9tZW51X2ZpbGVdIl0KKyAgICBpZiB7W2NhdGNoIHtleGVjIGdpdCBzaG93ICRkaWZmaWR0bzok
Zmxpc3RfbWVudV9maWxlID4gJGRpZmZ0b2ZpbGV9IGVycl19IHsKKyAgICAgIGVycm9yX3BvcHVw
ICJcIiRmbGlzdF9tZW51X2ZpbGVcIiBbbWMgImNhbm5vdCBiZSBmb3VuZCBpbiByZXZpc2lvbiJd
ICRkaWZmaWR0by4gW21jICJGaWxlIGhhcyBwcm9iYWJseSBiZWVuIGNyZWF0ZWQsIFwKKyAgICAg
ICAgICAgICAgICAgIGRlbGV0ZWQgb3IgcmVuYW1lZCwgaW4gYSBkaWZmZXJlbnQgY29tbWl0LiJd
IgorICAgICAgc2V0IGRpZmZvayAiZmFsc2UiCisgICAgfQorICB9CisKKyAgaWYgeyRkaWZmaWRm
cm9tID09ICRudWxsaWQgfHwgJGRpZmZpZGZyb20gPT0gJG51bGxpZDJ9IHsKKyAgICBzZXQgZGlm
ZmZyb21maWxlIFtmaWxlIGpvaW4gJGdpdGRpciAiLi4iICRmbGlzdF9tZW51X2ZpbGVdCisgIH0g
ZWxzZSB7CisgICAgc2V0IGRpZmZmcm9tZmlsZSBbZmlsZSBqb2luICRkaWZmZGlyICJcWyRkaWZm
aWRmcm9tXF0gW2ZpbGUgdGFpbCAkZmxpc3RfbWVudV9maWxlXSJdCisgICAgaWYge1tjYXRjaCB7
ZXhlYyBnaXQgc2hvdyAkZGlmZmlkZnJvbTokZmxpc3RfbWVudV9maWxlID4gJGRpZmZmcm9tZmls
ZX0gZXJyXX0geworICAgICAgZXJyb3JfcG9wdXAgIlwiJGZsaXN0X21lbnVfZmlsZVwiIFttYyAi
Y2Fubm90IGJlIGZvdW5kIGluIHJldmlzaW9uIl0gJGRpZmZpZGZyb20uIFttYyAiRmlsZSBoYXMg
cHJvYmFibHkgYmVlbiBjcmVhdGVkLCBcCisgICAgICAgICAgICAgICAgICBkZWxldGVkIG9yIHJl
bmFtZWQsIGluIGEgZGlmZmVyZW50IGNvbW1pdC4iXSIKKyAgICAgIHNldCBkaWZmb2sgImZhbHNl
IgorICAgIH0KKyAgfQorCisgIGlmIHskZGlmZm9rfSB7CisgICAgIyBoZXJlIHdlIGRvbid0IHVz
ZSBzaGVsbHF1b3RlIGJlY2F1c2UgXCBhbmQgZXZlcnl0aGluZyBtdXN0IGJlIGVzY2FwZWQgYW5k
IG5vdCBlbmNsb3NlZCBiZXR3ZWVuICcnCisgICAgc2V0IHF1b3RlZGV4dGRpZmZ0b29sIFwiW3N0
cmluZyBtYXAge1wiIFxcXCIgXFwgXFxcXCBcICBcXFwgfSAkZXh0ZGlmZnRvb2xdXCIKKyAgICBz
ZXQgY21kIFtjb25jYXQgfCAkcXVvdGVkZXh0ZGlmZnRvb2wgW3NoZWxsYXJnbGlzdCBbbGlzdCAk
ZGlmZmZyb21maWxlICRkaWZmdG9maWxlXV1dCisgICAgaWYge1tjYXRjaCB7c2V0IGZsIFtvcGVu
ICRjbWRdfSBlcnJdfSB7CisgICAgICBmaWxlIGRlbGV0ZSAtZm9yY2UgWyBmaWxlIGpvaW4gJGdp
dGt0bXBkaXIgJGRpZmZudW0gXQorICAgICAgZXJyb3JfcG9wdXAgW21jICIkZXh0ZGlmZnRvb2wg
Y29tbWFuZCBmYWlsZWQ6ICRlcnIiXQorICAgIH0gZWxzZSB7CisgICAgICBmY29uZmlndXJlICRm
bCAtYmxvY2tpbmcgMAorICAgICAgZmlsZXJ1biAkZmwgW2xpc3QgZmlsZSBkZWxldGUgLWZvcmNl
IFtmaWxlIGpvaW4gJGdpdGt0bXBkaXIgJGRpZmZudW1dXQorICAgIH0KKyAgfQorfQorCiAjIEZ1
bmN0aW9ucyBmb3IgYWRkaW5nIGFuZCByZW1vdmluZyBzaGVsbC10eXBlIHF1b3RpbmcKIAogcHJv
YyBzaGVsbHF1b3RlIHtzdHJ9IHsKQEAgLTc4MDIsOSArNzg4OSwxMyBAQCBwcm9jIHNob3d0YWcg
e3RhZyBpc25ld30gewogCiBwcm9jIGRvcXVpdCB7fSB7CiAgICAgZ2xvYmFsIHN0b3BwZWQKKyAg
ICBnbG9iYWwgZ2l0a3RtcGRpcgorCiAgICAgc2V0IHN0b3BwZWQgMTAwCiAgICAgc2F2ZXN0dWZm
IC4KICAgICBkZXN0cm95IC4KKworICAgIGNhdGNoIHtmaWxlIGRlbGV0ZSAtZm9yY2UgJGdpdGt0
bXBkaXJ9CiB9CiAKIHByb2MgbWtmb250ZGlzcCB7Zm9udCB0b3Agd2hpY2h9IHsKQEAgLTc5MzMs
NyArODAyNCw3IEBAIHByb2MgZG9wcmVmcyB7fSB7CiAgICAgZ2xvYmFsIG1heHdpZHRoIG1heGdy
YXBocGN0CiAgICAgZ2xvYmFsIG9sZHByZWZzIHByZWZzdG9wIHNob3duZWFydGFncyBzaG93bG9j
YWxjaGFuZ2VzCiAgICAgZ2xvYmFsIGJnY29sb3IgZmdjb2xvciBjdGV4dCBkaWZmY29sb3JzIHNl
bGVjdGJnY29sb3IKLSAgICBnbG9iYWwgdGFic3RvcCBsaW1pdGRpZmZzCisgICAgZ2xvYmFsIHRh
YnN0b3AgbGltaXRkaWZmcyBleHRkaWZmdG9vbAogCiAgICAgc2V0IHRvcCAuZ2l0a3ByZWZzCiAg
ICAgc2V0IHByZWZzdG9wICR0b3AKQEAgLTc5ODAsNiArODA3MSwxMSBAQCBwcm9jIGRvcHJlZnMg
e30gewogICAgIHBhY2sgJHRvcC5sZGlmZi5iICR0b3AubGRpZmYubCAtc2lkZSBsZWZ0CiAgICAg
Z3JpZCB4ICR0b3AubGRpZmYgLXN0aWNreSB3CiAKKyAgICBlbnRyeSAkdG9wLmV4dGRpZmZ0IC10
ZXh0dmFyaWFibGUgZXh0ZGlmZnRvb2wKKyAgICBidXR0b24gJHRvcC5leHRkaWZmYiAtdGV4dCBb
bWMgIkV4dGVybmFsIGRpZmYgdG9vbCIgXSAtZm9udCBvcHRpb25mb250IC1jb21tYW5kIHtzZXQg
ZXh0ZGlmZnRvb2wgW3RrX2dldE9wZW5GaWxlIC10aXRsZSAiRXh0ZXJuYWwgZGlmZiB0b29sIiAt
bXVsdGlwbGUgImZhbHNlIl19CisgICAgZ3JpZCB4ICR0b3AuZXh0ZGlmZmIgJHRvcC5leHRkaWZm
dCAtc3RpY2t5IHcKKworCiAgICAgbGFiZWwgJHRvcC5jZGlzcCAtdGV4dCBbbWMgIkNvbG9yczog
cHJlc3MgdG8gY2hvb3NlIl0KICAgICBncmlkICR0b3AuY2Rpc3AgLSAtc3RpY2t5IHcgLXBhZHkg
MTAKICAgICBsYWJlbCAkdG9wLmJnIC1wYWR4IDQwIC1yZWxpZWYgc3VuayAtYmFja2dyb3VuZCAk
Ymdjb2xvcgpAQCAtODQ1NCw2ICs4NTUwLDggQEAgc2V0IHNob3dsb2NhbGNoYW5nZXMgMQogc2V0
IGxpbWl0ZGlmZnMgMQogc2V0IGRhdGV0aW1lZm9ybWF0ICIlWS0lbS0lZCAlSDolTTolUyIKIAor
c2V0IGV4dGRpZmZ0b29sICJtZWxkIgorCiBzZXQgY29sb3JzIHtncmVlbiByZWQgYmx1ZSBtYWdl
bnRhIGRhcmtncmV5IGJyb3duIG9yYW5nZX0KIHNldCBiZ2NvbG9yIHdoaXRlCiBzZXQgZmdjb2xv
ciBibGFjawpAQCAtODUwNyw2ICs4NjA1LDkgQEAgaWYgeyFbZmlsZSBpc2RpcmVjdG9yeSAkZ2l0
ZGlyXX0gewogICAgIGV4aXQgMQogfQogCitzZXQgZ2l0a3RtcGRpciBbZmlsZSBub3JtYWxpemUg
W2ZpbGUgam9pbiAkZ2l0ZGlyICIuLiIgW2Zvcm1hdCAiLmdpdGstdG1wLiVzIiBbcGlkXV1dXQor
ZmlsZSBta2RpciAkZ2l0a3RtcGRpcgorCiBzZXQgbWVyZ2Vvbmx5IDAKIHNldCByZXZ0cmVlYXJn
cyB7fQogc2V0IGNtZGxpbmVfZmlsZXMge30KLS0gCjEuNS4zLjgKCg==


--=-HmumBa+VBEIJflyrHF5r--

From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Wed, 16 Nov 2011 11:51:33 +0300
Message-ID: <CACf55T5cp1ko45DCufcRXm=EeZd1-x+aYasvbzjDXkQH31u5VA@mail.gmail.com>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
	<CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
	<7v1ut9uglb.fsf@alter.siamese.dyndns.org>
	<CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com>
	<CALUzUxrM8o1uahQgSFUuvZ0mSPxG_zVQ9awOantRM2A8kkbbtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec5304f81fa416f04b1d6356c
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:51:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQbDY-0000Be-2E
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab1KPIvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 03:51:35 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57401 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1KPIve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 03:51:34 -0500
Received: by pzk36 with SMTP id 36so18052657pzk.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sN5fDErEw3+RozfSRkmcRoHRMTCJyZ8Ijgj6+NarpfA=;
        b=gYpnxcRwqT4cOiHOlkMhuBnxhXoY2SxV9ishLUv60d/LBMyXoun89iAVqn2SiJAL6T
         PletKawB/h4d/nmyYQUmXemjC5cTHTyGlK8qjoIfqXUOOOT0DES7c+h4T9g0lILEpdR0
         TK/BZ4ArPFzuaRb1DrJUey7zqccssulQi9tRU=
Received: by 10.68.59.98 with SMTP id y2mr30521467pbq.70.1321433493553; Wed,
 16 Nov 2011 00:51:33 -0800 (PST)
Received: by 10.68.66.230 with HTTP; Wed, 16 Nov 2011 00:51:33 -0800 (PST)
In-Reply-To: <CALUzUxrM8o1uahQgSFUuvZ0mSPxG_zVQ9awOantRM2A8kkbbtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185528>

--bcaec5304f81fa416f04b1d6356c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks.
I had collected two logs (for clone and ls-remote, attached).
Unfortunately, I cannot see, why problem occurs. The only indication is
* Connection #0 seems to be dead!

Is it possible that curl sends the request in plain text?
And according to tcpdump, why git/curl sends the request before Server Hell=
o?



2011/11/16 Tay Ray Chuan <rctay89@gmail.com>:
> On Wed, Nov 16, 2011 at 3:11 PM, Dmitry Smirnov <divis1969@gmail.com> wro=
te:
>> What if problem is caused by curl or TLS lib (libcurl-gnutls?) which
>> is used by my git? Is there any to log something from git-remote-https
>> ?
>
> You can run git with GIT_CURL_VERBOSE set, like this
>
> =A0GIT_CURL_VERBOSE=3D1 git ls-remote ...
>
> --
> Cheers,
> Ray Chuan
>

--bcaec5304f81fa416f04b1d6356c
Content-Type: text/x-log; charset=US-ASCII; name="clone.log"
Content-Disposition: attachment; filename="clone.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gv23ba830

ZHNtaXJub3ZAZHNtaXJub3YtdWJ1bnR1Mjp+L3Byb2plY3RzL3RtcCQgR0lUX0NVUkxfVkVSQk9T
RT0xIEdJVF9UUkFDRT10cnVlIGdpdCBjbG9uZSAtLXZlcmJvc2UgaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2dpdC9naXQuZ2l0CnRyYWNlOiBidWlsdC1pbjogZ2l0ICdjbG9uZScgJy0t
dmVyYm9zZScgJ2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9naXQvZ2l0LmdpdCcKQ2xv
bmluZyBpbnRvIGdpdC4uLgp0cmFjZTogcnVuX2NvbW1hbmQ6ICdnaXQtcmVtb3RlLWh0dHBzJyAn
b3JpZ2luJyAnaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2dpdC9naXQuZ2l0JwoqIENv
dWxkbid0IGZpbmQgaG9zdCBnaXQua2VybmVsLm9yZyBpbiB0aGUgLm5ldHJjIGZpbGU7IHVzaW5n
IGRlZmF1bHRzCiogQWJvdXQgdG8gY29ubmVjdCgpIHRvIHByb3h5IHByb3h5Lnl5eXl5Lnl5IHBv
cnQgMzEyOCAoIzApCiogICBUcnlpbmcgWS5ZLlkuWS4uLiAqIENvbm5lY3RlZCB0byBwcm94eS55
eXl5eS55eSAoWS5ZLlkuWSkgcG9ydCAzMTI4ICgjMCkKKiBFc3RhYmxpc2ggSFRUUCBwcm94eSB0
dW5uZWwgdG8gZ2l0Lmtlcm5lbC5vcmc6NDQzCj4gQ09OTkVDVCBnaXQua2VybmVsLm9yZzo0NDMg
SFRUUC8xLjEKSG9zdDogZ2l0Lmtlcm5lbC5vcmc6NDQzClVzZXItQWdlbnQ6IGdpdC8xLjcuNS40
ClByb3h5LUNvbm5lY3Rpb246IEtlZXAtQWxpdmUKUHJhZ21hOiBuby1jYWNoZQoKPCBIVFRQLzEu
MCAyMDAgQ29ubmVjdGlvbiBlc3RhYmxpc2hlZAo8IAoqIFByb3h5IHJlcGxpZWQgT0sgdG8gQ09O
TkVDVCByZXF1ZXN0CiogZm91bmQgMTU3IGNlcnRpZmljYXRlcyBpbiAvZXRjL3NzbC9jZXJ0cy9j
YS1jZXJ0aWZpY2F0ZXMuY3J0Cj4gR0VUIC9wdWIvc2NtL2dpdC9naXQuZ2l0L2luZm8vcmVmcz9z
ZXJ2aWNlPWdpdC11cGxvYWQtcGFjayBIVFRQLzEuMQpVc2VyLUFnZW50OiBnaXQvMS43LjUuNApI
b3N0OiBnaXQua2VybmVsLm9yZwpBY2NlcHQ6ICovKgpQcmFnbWE6IG5vLWNhY2hlCgoqIENvbm5l
Y3Rpb24gIzAgdG8gaG9zdCBwcm94eS55eXl5eS55eSBsZWZ0IGludGFjdAoqIENvdWxkbid0IGZp
bmQgaG9zdCBnaXQua2VybmVsLm9yZyBpbiB0aGUgLm5ldHJjIGZpbGU7IHVzaW5nIGRlZmF1bHRz
CiogQ29ubmVjdGlvbiAjMCBzZWVtcyB0byBiZSBkZWFkIQoqIENsb3NpbmcgY29ubmVjdGlvbiAj
MAoqIEFib3V0IHRvIGNvbm5lY3QoKSB0byBwcm94eSBwcm94eS55eXl5eS55eSBwb3J0IDMxMjgg
KCMwKQoqICAgVHJ5aW5nIFkuWS5ZLlkuLi4gKiBDb25uZWN0ZWQgdG8gcHJveHkueXl5eXkueXkg
KFkuWS5ZLlkpIHBvcnQgMzEyOCAoIzApCiogRXN0YWJsaXNoIEhUVFAgcHJveHkgdHVubmVsIHRv
IGdpdC5rZXJuZWwub3JnOjQ0Mwo+IENPTk5FQ1QgZ2l0Lmtlcm5lbC5vcmc6NDQzIEhUVFAvMS4x
Ckhvc3Q6IGdpdC5rZXJuZWwub3JnOjQ0MwpVc2VyLUFnZW50OiBnaXQvMS43LjUuNApQcm94eS1D
b25uZWN0aW9uOiBLZWVwLUFsaXZlClByYWdtYTogbm8tY2FjaGUKCjwgSFRUUC8xLjAgMjAwIENv
bm5lY3Rpb24gZXN0YWJsaXNoZWQKPCAKKiBQcm94eSByZXBsaWVkIE9LIHRvIENPTk5FQ1QgcmVx
dWVzdAoqIGZvdW5kIDE1NyBjZXJ0aWZpY2F0ZXMgaW4gL2V0Yy9zc2wvY2VydHMvY2EtY2VydGlm
aWNhdGVzLmNydAo+IEdFVCAvcHViL3NjbS9naXQvZ2l0LmdpdC9IRUFEIEhUVFAvMS4xClVzZXIt
QWdlbnQ6IGdpdC8xLjcuNS40Ckhvc3Q6IGdpdC5rZXJuZWwub3JnCkFjY2VwdDogKi8qClByYWdt
YTogbm8tY2FjaGUKCiogQ29ubmVjdGlvbiAjMCB0byBob3N0IHByb3h5Lnl5eXl5Lnl5IGxlZnQg
aW50YWN0Cndhcm5pbmc6IHJlbW90ZSBIRUFEIHJlZmVycyB0byBub25leGlzdGVudCByZWYsIHVu
YWJsZSB0byBjaGVja291dC4K
--bcaec5304f81fa416f04b1d6356c
Content-Type: text/x-log; name="ls-remote.log"
Content-Disposition: attachment; filename="ls-remote.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gv23btfi1

ZHNtaXJub3ZAZHNtaXJub3YtdWJ1bnR1Mjp+L3Byb2plY3RzL3RtcCQgR0lUX0NVUkxfVkVSQk9T
RT0xIEdJVF9UUkFDRT10cnVlIGdpdCBscy1yZW1vdGUgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2dpdC9naXQuZ2l0CnRyYWNlOiBidWlsdC1pbjogZ2l0ICdscy1yZW1vdGUnICdodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZ2l0L2dpdC5naXQnCnRyYWNlOiBydW5fY29tbWFu
ZDogJ2dpdC1yZW1vdGUtaHR0cHMnICdodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZ2l0
L2dpdC5naXQnICdodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZ2l0L2dpdC5naXQnCiog
Q291bGRuJ3QgZmluZCBob3N0IGdpdC5rZXJuZWwub3JnIGluIHRoZSAubmV0cmMgZmlsZTsgdXNp
bmcgZGVmYXVsdHMKKiBBYm91dCB0byBjb25uZWN0KCkgdG8gcHJveHkgcHJveHkueXl5eXkueXkg
cG9ydCAzMTI4ICgjMCkKKiAgIFRyeWluZyBZLlkuWS5ZLi4uICogQ29ubmVjdGVkIHRvIHByb3h5
Lnl5eXl5Lnl5IChZLlkuWS5ZKSBwb3J0IDMxMjggKCMwKQoqIEVzdGFibGlzaCBIVFRQIHByb3h5
IHR1bm5lbCB0byBnaXQua2VybmVsLm9yZzo0NDMKPiBDT05ORUNUIGdpdC5rZXJuZWwub3JnOjQ0
MyBIVFRQLzEuMQpIb3N0OiBnaXQua2VybmVsLm9yZzo0NDMKVXNlci1BZ2VudDogZ2l0LzEuNy41
LjQKUHJveHktQ29ubmVjdGlvbjogS2VlcC1BbGl2ZQpQcmFnbWE6IG5vLWNhY2hlCgo8IEhUVFAv
MS4wIDIwMCBDb25uZWN0aW9uIGVzdGFibGlzaGVkCjwgCiogUHJveHkgcmVwbGllZCBPSyB0byBD
T05ORUNUIHJlcXVlc3QKKiBmb3VuZCAxNTcgY2VydGlmaWNhdGVzIGluIC9ldGMvc3NsL2NlcnRz
L2NhLWNlcnRpZmljYXRlcy5jcnQKPiBHRVQgL3B1Yi9zY20vZ2l0L2dpdC5naXQvaW5mby9yZWZz
P3NlcnZpY2U9Z2l0LXVwbG9hZC1wYWNrIEhUVFAvMS4xClVzZXItQWdlbnQ6IGdpdC8xLjcuNS40
Ckhvc3Q6IGdpdC5rZXJuZWwub3JnCkFjY2VwdDogKi8qClByYWdtYTogbm8tY2FjaGUKCiogQ29u
bmVjdGlvbiAjMCB0byBob3N0IHByb3h5Lnl5eXl5Lnl5IGxlZnQgaW50YWN0CiogQ291bGRuJ3Qg
ZmluZCBob3N0IGdpdC5rZXJuZWwub3JnIGluIHRoZSAubmV0cmMgZmlsZTsgdXNpbmcgZGVmYXVs
dHMKKiBDb25uZWN0aW9uICMwIHNlZW1zIHRvIGJlIGRlYWQhCiogQ2xvc2luZyBjb25uZWN0aW9u
ICMwCiogQWJvdXQgdG8gY29ubmVjdCgpIHRvIHByb3h5IHByb3h5Lnl5eXl5Lnl5IHBvcnQgMzEy
OCAoIzApCiogICBUcnlpbmcgWS5ZLlkuWS4uLiAqIENvbm5lY3RlZCB0byBwcm94eS55eXl5eS55
eSAoWS5ZLlkuWSkgcG9ydCAzMTI4ICgjMCkKKiBFc3RhYmxpc2ggSFRUUCBwcm94eSB0dW5uZWwg
dG8gZ2l0Lmtlcm5lbC5vcmc6NDQzCj4gQ09OTkVDVCBnaXQua2VybmVsLm9yZzo0NDMgSFRUUC8x
LjEKSG9zdDogZ2l0Lmtlcm5lbC5vcmc6NDQzClVzZXItQWdlbnQ6IGdpdC8xLjcuNS40ClByb3h5
LUNvbm5lY3Rpb246IEtlZXAtQWxpdmUKUHJhZ21hOiBuby1jYWNoZQoKPCBIVFRQLzEuMCAyMDAg
Q29ubmVjdGlvbiBlc3RhYmxpc2hlZAo8IAoqIFByb3h5IHJlcGxpZWQgT0sgdG8gQ09OTkVDVCBy
ZXF1ZXN0CiogZm91bmQgMTU3IGNlcnRpZmljYXRlcyBpbiAvZXRjL3NzbC9jZXJ0cy9jYS1jZXJ0
aWZpY2F0ZXMuY3J0Cj4gR0VUIC9wdWIvc2NtL2dpdC9naXQuZ2l0L0hFQUQgSFRUUC8xLjEKVXNl
ci1BZ2VudDogZ2l0LzEuNy41LjQKSG9zdDogZ2l0Lmtlcm5lbC5vcmcKQWNjZXB0OiAqLyoKUHJh
Z21hOiBuby1jYWNoZQoKKiBDb25uZWN0aW9uICMwIHRvIGhvc3QgcHJveHkueXl5eXkueXkgbGVm
dCBpbnRhY3QKMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMAkDAQowMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCUNhcGUKMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMAkGA1UEBhMCVVMxEzARBgNVEwpjYTAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCQYDVQQGEwJVUzETMBEGA1UTCgEBATAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAJKu+/vUjvv70KAQEBMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMAkq77+9SO+/vQowMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwCQowMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
CSjvv73vv71277+9S1zvv71N77+9ZO+/ve+/ve+/ve+/ve+/vUjvv73vv73vv71vEG8Z77+977+9
HUTvv73vv73vv73vv71d77+977+9Z++/vQJJAe+/vUZv77+9Me+/ve+/ve+/ve+3i++/ve+/vV8C
XlUj77+977+9Mm/vv73vv73vv73vv73vv70KCg==
--bcaec5304f81fa416f04b1d6356c--

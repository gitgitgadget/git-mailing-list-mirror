From: Greg Price <price@MIT.EDU>
Subject: Re: Fwd: [PATCH 0/6] rebase: command "ref" and options
	--rewrite-{refs,heads,tags}
Date: Tue, 28 Jun 2011 06:47:58 -0400
Message-ID: <20110628104758.GS5771@dr-wily.mit.edu>
References: <cover.1309133817.git.greg@quora.com> <7vhb7bxgt9.fsf@alter.siamese.dyndns.org> <BANLkTinDFYsw7-N=_Ex8i42So_0LzVAWvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 13:01:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbW2r-0001BD-Mh
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 13:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811Ab1F1Kt1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 06:49:27 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:45621 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755066Ab1F1KsC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 06:48:02 -0400
X-AuditID: 1209190f-b7b0eae000000a42-d3-4e09b1623fc5
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A3.E9.02626.261B90E4; Tue, 28 Jun 2011 06:48:02 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id p5SAm0jB006405;
	Tue, 28 Jun 2011 06:48:00 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5SAlwjH014497;
	Tue, 28 Jun 2011 06:47:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vhb7bxgt9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IR4hRV1k3ayOln0D3Z0qLrSjeTRUPvFWYH
	Jo+Ll5Q9Pm+SC2CK4rJJSc3JLEst0rdL4Mr4sze84JtUxZ7DX5gbGGeLdjFyckgImEg82HqS
	FcIWk7hwbz1bFyMXh5DAPkaJldN3MkE4Gxgl1vzpgnK+MEq0rH/FDtLCIqAqcbHlGSOIzSag
	IPFj/jpmEFtEQE1iYtshFhCbWUBcYt3c82D1wgKxEveeLGQCsXkFjCWWTz7OCDF0AqPEwRNf
	GSESghInZz6BataR2Ln1DtBNHEC2tMTyfxwQYXmJ5q2zwXZxCphJ3Nq0mR2kRFRARWLV0swJ
	jEKzkAyahWTQLIRBs5AMWsDIsopRNiW3Sjc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyM4
	0CX5dzB+O6h0iFGAg1GJh5dpJYefEGtiWXFl7iFGSQ4mJVHevA2cfkJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeKcaAeV4UxIrq1KL8mFS0hwsSuK85d7/fYUE0hNLUrNTUwtSi2CyMhwcShK8
	60GGChalpqdWpGXmlCCkmTg4QYbzAA1fCVLDW1yQmFucmQ6RP8WoKCXOuwIkIQCSyCjNg+uF
	JaJXjOJArwjz3gep4gEmMbjuV0CDmYAGl9WCDS5JREhJNTAGMv79Y/9rivEKAweVg7sunKvN
	+8qaqObvejOu7dQ2na91OVaSZ7heME/6XuoZtnVZk+HLA2tS15V3Vf2SOD3zn0ruo+k7d+R7
	JE9Ov+r1WculO1Ciw+neXa53bDnrnl5r3TJLI7nOunOn/AvWFuEJtxf33uU5f89E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176390>

On Mon, Jun 27, 2011 at 11:36 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Thanks for a re-roll.
>=20
> I notice that this does not address the "side branch" issue raised du=
ring
> the original discussion. I do agree with Michael
>=20
> =A0http://thread.gmane.org/gmane.comp.version-control.git/135601/focu=
s=3D135617
>=20
> that having some commits on these part$N side branches is far more co=
mmon
> use case that would benefit from a "rewrite together" feature like th=
is,
> than moving part$N side branches that just mark points in the topic
> without doing anything on their own and makes me doubt if doing only =
the
> parts that can sanely done within the limitation of the current rebas=
e-i
> implementation like this series does adds much value to the system [*=
1*].

I would also like to support that use case.  In my personal
experience, the case where the part$N are ancestors of the topic has
actually been the more common case; typically it's that part1 is some
topic, and then part2 is a further topic that depends on the changes
in part1, so naturally it goes directly on top of it.  So I'd be
pleased to get the functionality of the present series in, even before
supporting the more general case.

I agree with your footnote -- the more general case will require a
more powerful sequencer to support properly.  And now I see that
Ramkumar Ramachandra is making progress on such a thing right now!
That's great news -- this is a project that has been attempted at
least four times, by five people (including me), in the last three
years.  I hope to see this round make it in -- I was actually thinking
about returning to the problem after seeing this series through, but I
would be glad to see Ram beat me to it.

When the more powerful sequencer comes along, it may be necessary to
rewrite some of this code in C (IIUC how the new sequencer will work),
but that shouldn't be hard, and is probably easier starting from a
shell version than from scratch.  Other than that, this code should go
in smoothly as the main ingredient, other than the sequencer itself,
needed for the general "rewrite side branches" feature.  With that and
because this series is independently useful, my suggestion would be to
merge it when it's ready in itself, without waiting for the sequencer.



> It would be nice to have a clear definition of what _should_ happen i=
n
> this case, and a test that makes sure that that is the behaviour we g=
et.
>=20
> Starting from this topology
>=20
> =A0 =A0 =A0 =A0 =A01 =A0 2 =A0 topic
> =A0A---X---Y---Z---W
> =A0 \
> =A0 =A0B
>=20
> where the change going from A to B is an equilvalent to the change go=
ing
> from Y to Z, a rebase of A..W would reproduce this topology:
>=20
>=20
> =A0 =A0 =A0 =A0 =A01 =A0 2 =A0 topic
> =A0A---X---Y---Z---W
> =A0 \
> =A0 =A0B---X'--Y'--W'
> =A0 =A0 =A0 =A0 =A0 =A01' =A0topic'
>=20
> What should heppen to ref2? Should it be deleted? Should it point at =
Y'?

I would have it point at Y'.  That's what would happen if we just said
"git rebase B ref2" (or threw in --rewrite-heads to pull along ref1),
and I think it makes the most sense to be consistent.

This consistency also means we can think of the reset that rebase
performs when it finishes as equivalent to an implicit
"ref refs/heads/topic" command at the end of the TODO file, which I
wouldn't point out in explaining to a beginner but I think is a nice
property for "ref" to have.

I'll add a test for this scenario.

Greg

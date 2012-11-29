From: Markus Schaber <m.schaber@codesys.com>
Subject: AW: reposurgeon now writes Subversion repositories
Date: Thu, 29 Nov 2012 13:43:06 +0000
Message-ID: <727D8E16AE957149B447FE368139F2B50D9951CB@SERVER10>
References: <20121129055946.2D7B84065F@snark.thyrsus.com>
 <20121129075829.GE3424@lp-shahaf.local> <20121129114637.GB9264@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "dev@subversion.apache.org" <dev@subversion.apache.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
To: "esr@thyrsus.com" <esr@thyrsus.com>, Daniel Shahaf <danielsh@elego.de>
X-From: dev-return-23050-gcvsd-dev=m.gmane.org@subversion.apache.org Thu Nov 29 14:44:34 2012
Return-path: <dev-return-23050-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@plane.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-23050-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1Te4Pk-00087A-JL
	for gcvsd-dev@plane.gmane.org; Thu, 29 Nov 2012 14:44:29 +0100
Received: (qmail 60535 invoked by uid 500); 29 Nov 2012 13:44:16 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 60514 invoked by uid 99); 29 Nov 2012 13:44:15 -0000
Received: from athena.apache.org (HELO athena.apache.org) (140.211.11.136)
    by apache.org (qpsmtpd/0.29) with ESMTP; Thu, 29 Nov 2012 13:44:15 +0000
X-ASF-Spam-Status: No, hits=-0.7 required=5.0
	tests=RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (athena.apache.org: local policy)
Received: from [213.182.0.52] (HELO mail-a.speedkom.net) (213.182.0.52)
    by apache.org (qpsmtpd/0.29) with ESMTP; Thu, 29 Nov 2012 13:44:09 +0000
Received: from SERVER10.in.3s-software.com (pat-out.3s-software.com [213.182.7.179])
	by mail-a.speedkom.net with ESMTP id qATDh7mo010220
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 29 Nov 2012 14:43:07 +0100
Received: from SERVER10.in.3s-software.com ([192.168.100.4]) by SERVER10
 ([192.168.100.4]) with mapi id 14.02.0318.004; Thu, 29 Nov 2012 14:43:07
 +0100
Thread-Topic: reposurgeon now writes Subversion repositories
Thread-Index: AQHNzfbcRL33TN6HhEKKaUSYBNM+K5gAYfGAgAA/vYCAADBWQA==
In-Reply-To: <20121129114637.GB9264@thyrsus.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.101.12]
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210832>

Hi,

Von: Eric S. Raymond [mailto:esr@thyrsus.com]
> > How does reposurgeon handle empty directories with (node) properties?
>=20
> Currently by ignoring all of them except svn:ignore, which it turns
> into .gitignore content on the gitspace side.  And now vice-versa, too.
>=20
> Not clear what else it *could* do.  I'd take suggestions.

AFAIR, SvnBridge (which bridges SVN to Team Foundation Server for CodePlex)=
 creates a hidden .svnproperties file where all the properties of the direc=
tory and files are stored.

I'm not really sure, but maybe this could be used as some standard to bridg=
e svn properties to non-svn VCSes.

Best regards

Markus Schaber

CODESYS(r) a trademark of 3S-Smart Software Solutions GmbH

Inspiring Automation Solutions

3S-Smart Software Solutions GmbH
Dipl.-Inf. Markus Schaber | Product Development Core Technology
Memminger Str. 151 | 87439 Kempten | Germany
Tel. +49-831-54031-979 | Fax +49-831-54031-50

E-Mail: m.schaber@codesys.com | Web: http://www.codesys.com
CODESYS internet forum: http://forum.codesys.com

Managing Directors: Dipl.Inf. Dieter Hess, Dipl.Inf. Manfred Werner | Trade=
 register: Kempten HRB 6186 | Tax ID No.: DE 167014915
